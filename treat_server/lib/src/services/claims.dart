import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../domain/rules.dart';
import '../generated/protocol.dart';
import 'accounts.dart';
import 'demo.dart';
import 'jobs.dart';

String claimChannel(int claimId) => 'claim:$claimId';
String shopChannel(int shopId) => 'shop:$shopId';
String expireCallId(int claimId) => 'expire-claim-$claimId';

/// Everyone watching live drops listens here.
const dropsChannel = 'drops';

Future<void> notifyDropChanged(Session session, int offerId) =>
    session.messages.postMessage(dropsChannel, DropSignal(offerId: offerId));

/// QR payload: `treat:<claimId>:<code>`. Shops may also type the bare code.
String qrPayloadOf(Claim c) => 'treat:${c.id}:${c.code}';

/// Tells live screens (student claim view, shop feed) that [claim] changed.
/// Local to this server instance; watchers also re-check the DB, so a missed
/// message only delays an update (see `ClaimEndpoint.watch`).
Future<void> notifyClaimChanged(Session session, Claim claim) async {
  await session.messages.postMessage(claimChannel(claim.id!), claim);
  await session.messages.postMessage(shopChannel(claim.shopId), claim);
  // Stock on a drop changed (claimed, or an unpicked item expired).
  if (claim.fromDrop) {
    await notifyDropChanged(session, claim.offerId);
  }
}

Future<ClaimView> claimViewOf(
  Session session,
  Claim claim, {
  Transaction? transaction,
}) async {
  final offer = await Offer.db.findById(
    session,
    claim.offerId,
    include: Offer.include(shop: Shop.include()),
    transaction: transaction,
  );
  return ClaimView(
    claim: presentable(claim, clock()),
    offer: offer!.copyWith(shop: null),
    shop: offer.shop!,
    sampleProof: isSampleProof(claim),
  );
}

/// What clients see: a TTL-expired claim shows as expired even before the
/// ExpireClaim future call has written it.
Claim presentable(Claim c, DateTime now) {
  final status = effectiveStatus(c, now);
  return status == c.status ? c : c.copyWith(status: status);
}

/// Creates a claim for the signed-in student. All rules are re-checked inside
/// a transaction that locks the student and the offer, so double taps and
/// concurrent students can't exceed caps or frequency limits.
Future<ClaimView> createClaim(Session session, int offerId) async {
  final authUserId = requireAuthUserId(session);
  final claim = await session.db.transaction((tx) async {
    final now = clock();
    final student = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    if (student == null) throw treatError('not_a_student');

    final offer = await Offer.db.findById(
      session,
      offerId,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    if (offer == null) throw treatError('offer_not_found');

    final offerClaims = await Claim.db.find(
      session,
      where: (t) =>
          t.offerId.equals(offerId) & t.status.notEquals(ClaimStatus.expired),
      transaction: tx,
    );
    final usage = usageOf(offerId, offerClaims, now);
    final shopClaims = await Claim.db.find(
      session,
      where: (t) =>
          t.studentId.equals(student.id!) & t.shopId.equals(offer.shopId),
      transaction: tx,
    );
    final eligibility = eligibilityOf(
      offer: offer,
      student: student,
      shopClaims: shopClaims,
      claimedToday: usage.today,
      claimedTotal: usage.total,
      now: now,
    );
    if (eligibility.reason != EligibilityReason.ok) {
      throw treatError('ineligible', eligibility.reason.name);
    }

    return Claim.db.insertRow(
      session,
      Claim(
        offerId: offerId,
        shopId: offer.shopId,
        studentId: student.id!,
        studentName: student.name,
        frequency: offer.frequency,
        fromDrop: offer.kind == OfferKind.drop,
        code: await _uniqueCode(session, offer.shopId, now, tx),
        status: ClaimStatus.active,
        createdAt: now,
        expiresAt: claimExpiry(offer, now),
      ),
      transaction: tx,
    );
  });

  await scheduleExpiry(session, claim);
  await notifyClaimChanged(session, claim);
  return claimViewOf(session, claim);
}

/// A code not used by any of the shop's live claims.
Future<String> _uniqueCode(
  Session session,
  int shopId,
  DateTime now,
  Transaction tx,
) async {
  for (var attempt = 0; attempt < 20; attempt++) {
    final code = newClaimCode();
    final clash = await Claim.db.findFirstRow(
      session,
      where: (t) =>
          t.shopId.equals(shopId) &
          t.code.equals(code) &
          t.status.equals(ClaimStatus.active) &
          (t.expiresAt > now),
      transaction: tx,
    );
    if (clash == null) return code;
  }
  throw treatError('code_generation_failed');
}

/// Parses a scanned QR payload or a typed code.
({int? claimId, String code}) parseScan(String input) {
  final raw = input.trim().toUpperCase();
  final qr = RegExp(r'^TREAT:(\d+):([A-Z0-9]{6})$').firstMatch(raw);
  if (qr != null) {
    return (claimId: int.parse(qr.group(1)!), code: qr.group(2)!);
  }
  final code = raw.replaceAll(RegExp(r'[\s-]'), '');
  if (!RegExp(r'^[A-Z0-9]{6}$').hasMatch(code)) {
    throw treatError('not_found', 'No such code.');
  }
  return (claimId: null, code: code);
}

/// The shop scans a student's QR (or types the code). Idempotent: scanning
/// the same claim twice returns `alreadyRedeemed` and counts once.
Future<RedeemResult> redeemClaim(Session session, String input) async {
  final scan = parseScan(input);
  final result = await session.db.transaction((tx) async {
    final now = clock();
    final shop = await requireShop(session, transaction: tx);

    Claim? claim;
    if (scan.claimId != null) {
      claim = await Claim.db.findById(
        session,
        scan.claimId!,
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (claim != null && claim.code != scan.code) claim = null;
    } else {
      // Newest matching claim at this shop first; codes are only unique among
      // live claims, so an old redeemed claim may share a code.
      claim = await Claim.db.findFirstRow(
        session,
        where: (t) => t.shopId.equals(shop.id!) & t.code.equals(scan.code),
        orderBy: (t) => t.createdAt.desc(),
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      claim ??= await Claim.db.findFirstRow(
        session,
        where: (t) =>
            t.code.equals(scan.code) & t.status.equals(ClaimStatus.active),
        orderBy: (t) => t.createdAt.desc(),
        transaction: tx,
      );
    }

    if (claim == null) throw treatError('not_found', 'No such code.');
    if (claim.shopId != shop.id) {
      throw treatError(
        'wrong_shop',
        "This code belongs to another business's offer.",
      );
    }

    switch (effectiveStatus(claim, now)) {
      case ClaimStatus.active:
        break;
      case ClaimStatus.expired:
        if (claim.status == ClaimStatus.active) {
          claim = await Claim.db.updateRow(
            session,
            claim.copyWith(status: ClaimStatus.expired),
            transaction: tx,
          );
          return (claim: claim, already: false, expiredNow: true);
        }
        throw treatError('expired', 'This code has expired.');
      case ClaimStatus.redeemed:
      case ClaimStatus.proofPending:
      case ClaimStatus.approved:
      case ClaimStatus.rejected:
        return (claim: claim, already: true, expiredNow: false);
    }

    claim = await Claim.db.updateRow(
      session,
      claim.copyWith(status: ClaimStatus.redeemed, redeemedAt: now),
      transaction: tx,
    );
    final lockedShop = await Shop.db.findById(
      session,
      shop.id!,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    await Shop.db.updateRow(
      session,
      lockedShop!.copyWith(totalRedeems: lockedShop.totalRedeems + 1),
      transaction: tx,
    );
    return (claim: claim, already: false, expiredNow: false);
  });

  final claim = result.claim;
  if (result.expiredNow) {
    // Committed the expiry above, now report it.
    await notifyClaimChanged(session, claim);
    throw treatError('expired', 'This code has expired.');
  }
  if (!result.already) {
    await cancelExpiry(session, claim.id!);
    await notifyClaimChanged(session, claim);
  }
  return RedeemResult(
    view: await claimViewOf(session, claim),
    alreadyRedeemed: result.already,
  );
}

/// Run by the ExpireClaim future call at `expiresAt`.
Future<void> expireClaimIfDue(Session session, int claimId) async {
  final now = clock();
  final expired = await session.db.transaction((tx) async {
    final claim = await Claim.db.findById(
      session,
      claimId,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    if (claim == null || claim.status != ClaimStatus.active) return null;
    if (now.isBefore(claim.expiresAt)) return claim; // too early, see below
    return Claim.db.updateRow(
      session,
      claim.copyWith(status: ClaimStatus.expired),
      transaction: tx,
    );
  });
  if (expired == null) return;
  if (expired.status == ClaimStatus.active) {
    // Fired early (clock skew): try again at the real expiry.
    await scheduleExpiry(session, expired);
    return;
  }
  await notifyClaimChanged(session, expired);
}
