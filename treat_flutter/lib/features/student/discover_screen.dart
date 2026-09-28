import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../drops/drops_strip.dart';
import '../social/wall.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late Future<List<OfferCard>> _future = client.offer.listActive();
  final _search = TextEditingController();
  OfferCategory? _category;

  int _refreshes = 0;

  Future<void> _reload() async {
    final f = client.offer.listActive();
    setState(() {
      _future = f;
      _refreshes++;
    });
    await f.catchError((_) => <OfferCard>[]);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<OfferCard> _filter(List<OfferCard> cards) {
    final q = _search.text.trim().toLowerCase();
    return cards.where((c) {
      if (_category != null && c.offer.category != _category) return false;
      if (q.isEmpty) return true;
      return c.offer.title.toLowerCase().contains(q) ||
          c.shop.name.toLowerCase().contains(q) ||
          c.shop.district.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      body: SafeArea(
        child: AppWidth(
          child: RefreshIndicator(
            color: T.accent,
            onRefresh: _reload,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverList.list(
                    children: [
                      Text(l.discoverTitle, style: context.text.headlineMedium),
                      const SizedBox(height: 12),
                      const LiveDropsStrip(),
                      TextField(
                        controller: _search,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: l.discoverSearch,
                          prefixIcon: const Icon(Icons.search_rounded),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _chip(l.discoverAll, null),
                            for (final c in OfferCategory.values)
                              _chip(c.label(l), c),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_category == null && _search.text.isEmpty)
                        FreshWallStrip(key: ValueKey(_refreshes)),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _future,
                  builder: (context, snap) {
                    if (snap.hasError) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: ErrorView(error: snap.error!, onRetry: _reload),
                      );
                    }
                    if (!snap.hasData) {
                      return const SliverToBoxAdapter(child: LoadingView());
                    }
                    final cards = _filter(snap.data!);
                    if (cards.isEmpty) {
                      return SliverToBoxAdapter(
                        child: EmptyView(
                          icon: Icons.search_off_rounded,
                          title: l.discoverEmpty,
                          hint: l.discoverEmptyHint,
                        ),
                      );
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      sliver: SliverList.separated(
                        itemCount: cards.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 14),
                        itemBuilder: (context, i) => OfferTile(
                          card: cards[i],
                          onTap: () async {
                            await context.push('/offer/${cards[i].offer.id}');
                            if (mounted) _reload();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, OfferCategory? value) {
    final selected = _category == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        labelStyle: TextStyle(
          color: selected ? Colors.white : T.ink,
          fontWeight: FontWeight.w700,
        ),
        onSelected: (_) => setState(() => _category = value),
      ),
    );
  }
}

/// Photo card for one offer in Discover.
class OfferTile extends StatelessWidget {
  const OfferTile({super.key, required this.card, this.onTap});

  final OfferCard card;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final offer = card.offer;
    final dailyCap = offer.dailyCap;
    final left = dailyCap == null ? null : dailyCap - card.claimedToday;
    final eligibility = card.eligibility;
    // The "left today" pill already says a daily cap is used up.
    final lock =
        eligibility == null ||
            (eligibility.reason == EligibilityReason.dailyCap && left != null)
        ? null
        : lockShort(eligibility, l);

    return TreatCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 8,
                child: Image.asset(
                  offer.category.imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 12,
                top: 12,
                child: Row(
                  children: [
                    Pill(l.freeTag, tone: PillTone.accent),
                    if (offer.featured) ...[
                      const SizedBox(width: 6),
                      Pill(
                        l.discoverFeatured,
                        tone: PillTone.amber,
                        icon: Icons.star_rounded,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        card.shop.name,
                        style: context.text.labelLarge?.copyWith(
                          color: T.inkSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (card.shop.verified)
                      const Icon(
                        Icons.verified_rounded,
                        size: 16,
                        color: T.green,
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(offer.title, style: context.text.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    Pill(offer.frequency.label(l)),
                    Pill(
                      '${hhmm(offer.activeStartMin)}–${hhmm(offer.activeEndMin)}',
                      icon: Icons.schedule_rounded,
                    ),
                    if (left != null)
                      Pill(
                        left > 0 ? l.leftToday(left) : l.soldOutToday,
                        tone: left > 0 ? PillTone.green : PillTone.red,
                      ),
                    if (lock != null)
                      Pill(lock, icon: Icons.lock_outline_rounded),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
