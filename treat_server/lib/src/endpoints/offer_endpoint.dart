import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../domain/rules.dart';
import '../generated/protocol.dart';
import '../services/accounts.dart';
import '../services/claims.dart';
import '../services/offer_cards.dart';

/// Browsing offers (Discover + offer detail). Students also get their
/// eligibility for each offer, computed on the server.
class OfferEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// How often [watchDrops] re-reads even without a message: drops open and
  /// close on the clock, and this keeps several server instances in sync.
  static Duration dropsRecheck = const Duration(seconds: 10);

  /// Regular (standing) offers. Drops come from [watchDrops].
  Future<List<OfferCard>> listActive(Session session) async {
    final student = await findStudent(session, requireAuthUserId(session));
    final offers = await Offer.db.find(
      session,
      where: (t) =>
          t.status.equals(OfferStatus.active) &
          t.kind.equals(OfferKind.regular),
      orderByList: (t) => [t.featured.desc(), t.createdAt.desc()],
      include: Offer.include(shop: Shop.include()),
    );
    return buildOfferCards(session, offers, student: student, now: clock());
  }

  Future<OfferCard> get(Session session, int offerId) async {
    final student = await findStudent(session, requireAuthUserId(session));
    final offer = await Offer.db.findById(
      session,
      offerId,
      include: Offer.include(shop: Shop.include()),
    );
    if (offer == null || offer.status == OfferStatus.ended) {
      throw treatError('offer_not_found', 'This offer no longer exists.');
    }
    final cards = await buildOfferCards(
      session,
      [offer],
      student: student,
      now: clock(),
    );
    return cards.single;
  }

  /// Live drops, soonest-ending first: the current list, then a new list
  /// whenever one starts, ends, or its stock changes.
  Stream<List<OfferCard>> watchDrops(Session session) async* {
    final student = await findStudent(session, requireAuthUserId(session));
    var last = await _liveDrops(session, student);
    yield last;

    final wake = StreamController<void>();
    final messages = session.messages
        .createStream<DropSignal>(dropsChannel)
        .listen((_) => wake.add(null), onError: (_) => wake.add(null));
    final timer = Timer.periodic(dropsRecheck, (_) => wake.add(null));
    try {
      await for (final _ in wake.stream) {
        final next = await _liveDrops(session, student);
        if (_signature(next) == _signature(last)) continue;
        last = next;
        yield next;
      }
    } finally {
      timer.cancel();
      await messages.cancel();
      await wake.close();
    }
  }

  Future<List<OfferCard>> _liveDrops(
    Session session,
    StudentProfile? student,
  ) async {
    final now = clock();
    final drops = await Offer.db.find(
      session,
      where: (t) =>
          t.kind.equals(OfferKind.drop) &
          t.status.equals(OfferStatus.active) &
          (t.endsAt > now),
      orderBy: (t) => t.endsAt,
      include: Offer.include(shop: Shop.include()),
    );
    final cards = await buildOfferCards(
      session,
      drops.where((d) => isDropLive(d, now)).toList(),
      student: student,
      now: now,
    );
    return cards;
  }

  static String _signature(List<OfferCard> cards) => [
    for (final c in cards)
      '${c.offer.id}:${c.claimedTotal}:${c.eligibility?.reason.name}',
  ].join('|');
}
