import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import 'claim_screen.dart';

class MyClaimsScreen extends StatefulWidget {
  const MyClaimsScreen({super.key});

  @override
  State<MyClaimsScreen> createState() => _MyClaimsScreenState();
}

class _MyClaimsScreenState extends State<MyClaimsScreen> {
  late Future<List<ClaimView>> _future = client.claim.listMine();

  Future<void> _reload() async {
    final f = client.claim.listMine();
    setState(() => _future = f);
    await f.catchError((_) => <ClaimView>[]);
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
            child: FutureBuilder(
              future: _future,
              builder: (context, snap) {
                final header = Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    l.claimsTitle,
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
                final all = snap.data!;
                final active = all
                    .where((v) => v.claim.status == ClaimStatus.active)
                    .toList();
                final past = all
                    .where((v) => v.claim.status != ClaimStatus.active)
                    .toList();
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  children: [
                    header,
                    if (all.isEmpty)
                      EmptyView(
                        icon: Icons.local_offer_outlined,
                        title: l.claimsEmpty,
                        hint: l.claimsEmptyHint,
                        action: FilledButton(
                          onPressed: () => context.go('/discover'),
                          child: Text(l.claimsGoDiscover),
                        ),
                      ),
                    if (active.isNotEmpty) SectionTitle(l.claimsActive),
                    for (final v in active) _tile(v),
                    if (past.isNotEmpty) SectionTitle(l.claimsPast),
                    for (final v in past) _tile(v),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _tile(ClaimView v) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TreatCard(
      padding: const EdgeInsets.all(12),
      onTap: () async {
        await context.push('/claim/${v.claim.id}');
        if (mounted) _reload();
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(T.radiusSm),
            child: Image.asset(
              v.offer.category.imageAsset,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(v.offer.title, style: context.text.titleMedium),
                Text(
                  '${v.shop.name} · ${istanbulDateTime(v.claim.createdAt)}',
                  style: context.text.bodySmall?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Pill(
                  v.claim.status.label(context.l),
                  tone: claimTone(v.claim.status),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: T.inkTertiary),
        ],
      ),
    ),
  );
}
