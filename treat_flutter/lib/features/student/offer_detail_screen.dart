import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../drops/drops_strip.dart';

class OfferDetailScreen extends StatefulWidget {
  const OfferDetailScreen({super.key, required this.offerId});
  final int offerId;

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  late Future<OfferCard> _future = client.offer.get(widget.offerId);

  void _reload() => setState(() => _future = client.offer.get(widget.offerId));

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FutureBuilder(
      future: _future,
      builder: (context, snap) {
        if (snap.hasError) {
          return SafeArea(
            child: Column(
              children: [
                const _BackBar(),
                Expanded(
                  child: ErrorView(error: snap.error!, onRetry: _reload),
                ),
              ],
            ),
          );
        }
        if (!snap.hasData) return const LoadingView();
        return _Detail(card: snap.data!);
      },
    ),
  );
}

class _BackBar extends StatelessWidget {
  const _BackBar();

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: IconButton(
      onPressed: () => context.canPop() ? context.pop() : context.go('/'),
      icon: const Icon(Icons.arrow_back_rounded),
      tooltip: context.l.back,
    ),
  );
}

class _Detail extends StatelessWidget {
  const _Detail({required this.card});
  final OfferCard card;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final offer = card.offer;
    final shop = card.shop;
    final eligibility = card.eligibility;
    final isDrop = offer.kind == OfferKind.drop;
    final lock = eligibility == null
        ? (appSession.status == SessionStatus.shop ? l.lockShopView : null)
        : lockMessage(eligibility, l);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 220,
          pinned: true,
          backgroundColor: T.bg,
          leading: Padding(
            padding: const EdgeInsets.all(6),
            child: CircleAvatar(
              backgroundColor: T.card,
              child: IconButton(
                onPressed: () =>
                    context.canPop() ? context.pop() : context.go('/'),
                icon: const Icon(Icons.arrow_back_rounded, color: T.ink),
                tooltip: l.back,
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              offer.category.imageAsset,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppWidth(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isDrop) ...[
                        Pill(
                          l.dropBadge,
                          tone: PillTone.red,
                          icon: Icons.bolt_rounded,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Pill(offer.category.label(l), tone: PillTone.accent),
                      const SizedBox(width: 6),
                      if (shop.verified)
                        Pill(
                          l.offerVerifiedShop,
                          tone: PillTone.green,
                          icon: Icons.verified_rounded,
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(offer.title, style: context.text.headlineMedium),
                  const SizedBox(height: 4),
                  Text(
                    '${shop.name} · ${shop.district}',
                    style: context.text.titleMedium?.copyWith(
                      color: T.inkSecondary,
                    ),
                  ),
                  if (isDrop) ...[
                    const SizedBox(height: 12),
                    _DropStatus(card: card),
                  ],
                  const SizedBox(height: 12),
                  Text(offer.description, style: context.text.bodyLarge),
                  const SizedBox(height: 20),
                  if (lock != null) ...[
                    Notice(lock, icon: Icons.lock_outline_rounded),
                    const SizedBox(height: 12),
                  ],
                  if (eligibility != null) ...[
                    _ClaimButton(offerId: offer.id!, eligibility: eligibility),
                    const SizedBox(height: 8),
                    Text(
                      l.offerClaimHint,
                      textAlign: TextAlign.center,
                      style: context.text.bodySmall?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                  ],
                  SectionTitle(l.offerRules),
                  if (isDrop)
                    TreatCard(
                      child: _Row(Icons.bolt_rounded, l.dropRules),
                    )
                  else
                    TreatCard(
                      child: Column(
                        children: [
                          _Row(
                            Icons.repeat_rounded,
                            offer.frequency.longLabel(l),
                          ),
                          _Row(
                            Icons.schedule_rounded,
                            l.offerHoursValue(
                              hhmm(offer.activeStartMin),
                              hhmm(offer.activeEndMin),
                            ),
                          ),
                          if (offer.dailyCap != null)
                            _Row(
                              Icons.today_rounded,
                              '${l.offerDailyCap(offer.dailyCap!)} · '
                              '${l.leftToday((offer.dailyCap! - card.claimedToday).clamp(0, offer.dailyCap!))}',
                            ),
                          if (offer.totalCap != null)
                            _Row(
                              Icons.inventory_2_outlined,
                              l.offerTotalCap(offer.totalCap!),
                            ),
                        ],
                      ),
                    ),
                  SectionTitle(l.offerInReturn),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final p in offer.proofTypes)
                        Pill(p.label(l), icon: Icons.photo_camera_outlined),
                    ],
                  ),
                  SectionTitle(l.offerAboutShop),
                  TreatCard(
                    onTap: () => context.push('/place/${shop.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InitialsAvatar(shop.name),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shop.name,
                                    style: context.text.titleMedium,
                                  ),
                                  Text(
                                    shop.address,
                                    style: context.text.bodySmall?.copyWith(
                                      color: T.inkSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (shop.bio.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Text(shop.bio, style: context.text.bodyMedium),
                        ],
                        if (shop.instagramHandle != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            '@${shop.instagramHandle}',
                            style: context.text.labelLarge?.copyWith(
                              color: T.accentInk,
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              l.placeView,
                              style: context.text.labelLarge?.copyWith(
                                color: T.accentInk,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: T.accentInk,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 20, color: T.inkSecondary),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: context.text.bodyMedium)),
      ],
    ),
  );
}

class _ClaimButton extends StatefulWidget {
  const _ClaimButton({required this.offerId, required this.eligibility});
  final int offerId;
  final Eligibility eligibility;

  @override
  State<_ClaimButton> createState() => _ClaimButtonState();
}

class _ClaimButtonState extends State<_ClaimButton> {
  bool _busy = false;

  Future<void> _claim() async {
    setState(() => _busy = true);
    try {
      final view = await client.claim.create(widget.offerId);
      if (mounted) context.pushReplacement('/claim/${view.claim.id}');
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final e = widget.eligibility;
    const size = Size.fromHeight(52);
    if (e.reason == EligibilityReason.activeClaim && e.claimId != null) {
      return OutlinedButton.icon(
        onPressed: () => context.push('/claim/${e.claimId}'),
        icon: const Icon(Icons.qr_code_2_rounded),
        label: Text(l.offerGoToQr),
        style: OutlinedButton.styleFrom(minimumSize: size),
      );
    }
    return FilledButton.icon(
      onPressed: e.reason == EligibilityReason.ok && !_busy ? _claim : null,
      icon: _busy
          ? const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            )
          : const Icon(Icons.qr_code_2_rounded),
      label: Text(l.offerClaim),
      style: FilledButton.styleFrom(minimumSize: size),
    );
  }
}

class _DropStatus extends StatelessWidget {
  const _DropStatus({required this.card});
  final OfferCard card;

  @override
  Widget build(BuildContext context) => TreatCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Ticking(
          builder: (context, now) {
            final left = card.offer.endsAt!.difference(now);
            final ended = left <= Duration.zero;
            return Row(
              children: [
                if (!ended) const LivePulse(size: 8),
                const SizedBox(width: 6),
                Text(
                  ended
                      ? context.l.dropEnded
                      : context.l.dropEndsIn(countdown(left)),
                  style: context.text.titleMedium?.copyWith(
                    color: ended ? T.inkSecondary : T.red,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        DropStock(card: card),
      ],
    ),
  );
}
