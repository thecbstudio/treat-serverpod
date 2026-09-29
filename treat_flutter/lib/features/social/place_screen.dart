import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../drops/drops_strip.dart';
import '../student/discover_screen.dart' show OfferTile;
import 'wall.dart';

/// A place's public page: who they are, how many students they treated, what
/// they offer right now and what students posted about them.
class PlaceScreen extends StatefulWidget {
  const PlaceScreen({super.key, required this.shopId});
  final int shopId;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  late Future<ShopPage> _future = client.social.shopPage(widget.shopId);

  void _reload() =>
      setState(() => _future = client.social.shopPage(widget.shopId));

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FutureBuilder(
      future: _future,
      builder: (context, snap) {
        if (snap.hasError) {
          return SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    onPressed: () =>
                        context.canPop() ? context.pop() : context.go('/'),
                  ),
                ),
                Expanded(
                  child: ErrorView(error: snap.error!, onRetry: _reload),
                ),
              ],
            ),
          );
        }
        if (!snap.hasData) return const LoadingView();
        return _Page(page: snap.data!);
      },
    ),
  );
}

class _Page extends StatelessWidget {
  const _Page({required this.page});
  final ShopPage page;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final shop = page.shop;
    final drops = page.offers
        .where((c) => c.offer.kind == OfferKind.drop)
        .toList();
    final offers = page.offers
        .where((c) => c.offer.kind == OfferKind.regular)
        .toList();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
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
              shopPhoto(shop),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppWidth(
            wide: true,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InitialsAvatar(shop.name, size: 56),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    shop.name,
                                    style: context.text.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                if (shop.verified) ...[
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.verified_rounded,
                                    color: T.green,
                                    size: 20,
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              '${shop.category.label(l)} · ${shop.district}',
                              style: context.text.bodyMedium?.copyWith(
                                color: T.inkSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Pill(
                        l.placeTreated(page.studentsTreated),
                        tone: PillTone.accent,
                        icon: Icons.volunteer_activism_outlined,
                      ),
                      if (shop.instagramHandle != null)
                        Pill(
                          '@${shop.instagramHandle}',
                          icon: Icons.alternate_email_rounded,
                        ),
                    ],
                  ),
                  if (shop.bio.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(shop.bio, style: context.text.bodyLarge),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    shop.address,
                    style: context.text.bodySmall?.copyWith(
                      color: T.inkSecondary,
                    ),
                  ),
                  if (drops.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 176,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: drops.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, i) => DropCard(
                          card: drops[i],
                          onTap: () =>
                              context.push('/offer/${drops[i].offer.id}'),
                        ),
                      ),
                    ),
                  ],
                  SectionTitle(l.placeOffers),
                  if (offers.isEmpty)
                    Text(
                      l.placeNoOffers,
                      style: context.text.bodyMedium?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                  CardGrid(
                    itemCount: offers.length,
                    itemBuilder: (context, i) => OfferTile(
                      card: offers[i],
                      onTap: () => context.push('/offer/${offers[i].offer.id}'),
                    ),
                  ),
                  SectionTitle(l.wallTitle),
                  WallGrid(posts: page.wall),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
