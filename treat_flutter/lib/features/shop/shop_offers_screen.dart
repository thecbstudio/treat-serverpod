import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../drops/drops_strip.dart';

class ShopOffersScreen extends StatefulWidget {
  const ShopOffersScreen({super.key});

  @override
  State<ShopOffersScreen> createState() => _ShopOffersScreenState();
}

class _ShopOffersScreenState extends State<ShopOffersScreen> {
  late Future<List<OfferCard>> _future = client.shopOffers.listMine();

  Future<void> _reload() async {
    final f = client.shopOffers.listMine();
    setState(() => _future = f);
    await f.catchError((_) => <OfferCard>[]);
  }

  Future<void> _openForm([Offer? offer]) async {
    final changed = await context.push<bool>(
      offer == null ? '/shop/offers/new' : '/shop/offers/${offer.id}/edit',
      extra: offer,
    );
    if (changed == true) _reload();
  }

  Future<void> _openDropForm() async {
    final started = await context.push<bool>('/shop/drops/new');
    if (started == true) _reload();
  }

  Future<void> _endDrop(Offer drop) async {
    final l = context.l;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(l.shopDropEndConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: T.red),
            child: Text(l.shopDropEnd),
          ),
        ],
      ),
    );
    if (ok == true) await _setStatus(drop, OfferStatus.ended);
  }

  Future<void> _setStatus(Offer offer, OfferStatus status) async {
    try {
      await client.shopOffers.setStatus(offer.id!, status);
      await _reload();
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    }
  }

  Future<void> _delete(Offer offer) async {
    final l = context.l;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(l.shopDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: T.red),
            child: Text(l.shopDelete),
          ),
        ],
      ),
    );
    if (ok == true) await _setStatus(offer, OfferStatus.ended);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        backgroundColor: T.accent,
        foregroundColor: T.inkInverse,
        icon: const Icon(Icons.add_rounded),
        label: Text(l.shopNewOffer),
      ),
      body: SafeArea(
        child: AppWidth(
          child: RefreshIndicator(
            color: T.accent,
            onRefresh: _reload,
            child: FutureBuilder(
              future: _future,
              builder: (context, snap) {
                final header = Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Text(
                    l.shopOffersTitle,
                    style: context.text.headlineMedium,
                  ),
                );
                if (snap.hasError) {
                  return ListView(
                    children: [
                      header,
                      ErrorView(error: snap.error!, onRetry: _reload),
                    ],
                  );
                }
                if (!snap.hasData) return const LoadingView();
                final now = DateTime.now().toUtc();
                // Drops first (live ones on top); drops over a day old drop off.
                final drops =
                    snap.data!
                        .where(
                          (c) =>
                              c.offer.kind == OfferKind.drop &&
                              c.offer.endsAt!.isAfter(
                                now.subtract(const Duration(days: 1)),
                              ),
                        )
                        .toList()
                      ..sort(
                        (a, b) => b.offer.endsAt!.compareTo(a.offer.endsAt!),
                      );
                final cards = snap.data!
                    .where((c) => c.offer.kind == OfferKind.regular)
                    .toList();
                return ListView(
                  padding: const EdgeInsets.only(bottom: 96),
                  children: [
                    header,
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: _StartDropCard(onTap: _openDropForm),
                    ),
                    for (final d in drops)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: _ShopDropTile(
                          card: d,
                          onEnd: () => _endDrop(d.offer),
                        ),
                      ),
                    if (cards.isEmpty)
                      EmptyView(
                        icon: Icons.local_offer_outlined,
                        title: l.shopOffersEmpty,
                        hint: l.shopOffersEmptyHint,
                      ),
                    for (final card in cards)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: _ShopOfferTile(
                          card: card,
                          onEdit: () => _openForm(card.offer),
                          onToggle: () => _setStatus(
                            card.offer,
                            card.offer.status == OfferStatus.active
                                ? OfferStatus.paused
                                : OfferStatus.active,
                          ),
                          onDelete: () => _delete(card.offer),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopOfferTile extends StatelessWidget {
  const _ShopOfferTile({
    required this.card,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
  });

  final OfferCard card;
  final VoidCallback onEdit;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final offer = card.offer;
    final live = offer.status == OfferStatus.active;
    return TreatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Pill(
                live ? l.shopOfferLive : l.shopOfferPaused,
                tone: live ? PillTone.green : PillTone.neutral,
                icon: live ? Icons.circle : Icons.pause_rounded,
              ),
              const Spacer(),
              PopupMenuButton<String>(
                tooltip: '',
                onSelected: (v) => switch (v) {
                  'edit' => onEdit(),
                  'delete' => onDelete(),
                  _ => null,
                },
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'edit', child: Text(l.shopEdit)),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      l.shopDelete,
                      style: const TextStyle(color: T.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(offer.title, style: context.text.titleMedium),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              Pill(offer.frequency.label(l)),
              Pill(
                '${hhmm(offer.activeStartMin)}–${hhmm(offer.activeEndMin)}',
                icon: Icons.schedule_rounded,
              ),
              Pill(l.shopOfferClaimedToday(card.claimedToday)),
              Pill(l.shopOfferClaimedTotal(card.claimedTotal)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onEdit,
                  child: Text(l.shopEdit),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: onToggle,
                  child: Text(live ? l.shopPause : l.shopActivate),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StartDropCard extends StatelessWidget {
  const _StartDropCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.circular(T.radiusLg),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2A1F1A), T.ink]),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: T.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bolt_rounded, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l.shopStartDropCta,
                    style: context.text.titleMedium?.copyWith(
                      color: T.inkInverse,
                    ),
                  ),
                  Text(
                    context.l.shopStartDropHint,
                    style: context.text.bodySmall?.copyWith(
                      color: T.inkInverse.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: T.inkInverse),
          ],
        ),
      ),
    ),
  );
}

class _ShopDropTile extends StatelessWidget {
  const _ShopDropTile({required this.card, required this.onEnd});
  final OfferCard card;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final offer = card.offer;
    return TreatCard(
      child: Ticking(
        builder: (context, now) {
          final left = offer.endsAt!.difference(now);
          final live =
              offer.status == OfferStatus.active && left > Duration.zero;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Pill(
                    l.dropBadge,
                    tone: live ? PillTone.red : PillTone.neutral,
                    icon: Icons.bolt_rounded,
                  ),
                  const SizedBox(width: 8),
                  if (live) ...[
                    const LivePulse(size: 7),
                    Text(
                      l.dropEndsIn(countdown(left)),
                      style: context.text.labelLarge?.copyWith(
                        color: T.red,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ] else
                    Text(
                      l.dropEnded,
                      style: context.text.labelLarge?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(offer.title, style: context.text.titleMedium),
              const SizedBox(height: 8),
              if (live)
                DropStock(card: card)
              else
                Text(
                  l.dropClaimedOf(card.claimedTotal, offer.totalCap ?? 0),
                  style: context.text.bodyMedium?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
              if (live) ...[
                const SizedBox(height: 10),
                OutlinedButton(onPressed: onEnd, child: Text(l.shopDropEnd)),
              ],
            ],
          );
        },
      ),
    );
  }
}
