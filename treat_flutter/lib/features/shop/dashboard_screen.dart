import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../student/claim_screen.dart' show claimTone;

/// Business panel: numbers, ROI estimate and a live activity feed that
/// updates the moment a student claims, gets scanned, posts, or is judged.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ShopDashboard? _data;
  Object? _error;
  StreamSubscription<ClaimView>? _feed;
  int? _flashClaimId;
  int _feedRetries = 0;

  @override
  void initState() {
    super.initState();
    _load();
    _listen();
  }

  Future<void> _load() async {
    try {
      final data = await client.shop.dashboard();
      if (mounted) {
        setState(() {
          _data = data;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  void _listen() {
    _feed?.cancel();
    _feed = client.shop.watchFeed().listen(
      (view) {
        _feedRetries = 0;
        setState(() => _flashClaimId = view.claim.id);
        _load();
      },
      onError: (_) => _reconnect(),
      onDone: _reconnect,
    );
  }

  void _reconnect() {
    if (!mounted) return;
    _feedRetries += 1;
    Future.delayed(Duration(seconds: _feedRetries.clamp(1, 10)), () {
      if (mounted) {
        _listen();
        _load(); // catch up on anything missed while disconnected
      }
    });
  }

  @override
  void dispose() {
    _feed?.cancel();
    super.dispose();
  }

  Future<void> _showProof(ClaimView v) async {
    try {
      final link = await client.shop.proofLink(v.claim.id!);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          clipBehavior: Clip.antiAlias,
          child: InteractiveViewer(child: Image.network(link.url)),
        ),
      );
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final data = _data;
    return Scaffold(
      body: SafeArea(
        child: AppWidth(
          child: switch ((data, _error)) {
            (null, final Object e) => ErrorView(error: e, onRetry: _load),
            (null, _) => const LoadingView(),
            (final ShopDashboard d, _) => RefreshIndicator(
              color: T.accent,
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          d.shop.name,
                          style: context.text.headlineMedium,
                        ),
                      ),
                      Pill(
                        l.claimLive,
                        tone: PillTone.green,
                        icon: Icons.circle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Rows of equal-height cards; sized by content so nothing
                  // overflows on narrow phones.
                  for (final pair in [
                    [
                      (l.dashTotalRedeems, d.shop.totalRedeems),
                      (l.dashApprovedProofs, d.shop.approvedProofs),
                    ],
                    [
                      (l.dashActiveOffers, d.activeOffers),
                      (l.dashWeekClaims, d.claimsThisWeek),
                    ],
                  ]) ...[
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _Stat(pair[0].$1, '${pair[0].$2}')),
                          const SizedBox(width: 10),
                          Expanded(child: _Stat(pair[1].$1, '${pair[1].$2}')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  _RoiCard(data: d),
                  SectionTitle(l.dashLive),
                  if (d.recent.isEmpty)
                    Text(
                      l.dashEmpty,
                      style: context.text.bodyMedium?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                  for (final v in d.recent)
                    _FeedRow(
                      view: v,
                      flash: v.claim.id == _flashClaimId,
                      onViewProof:
                          v.claim.status == ClaimStatus.approved ||
                              v.claim.status == ClaimStatus.rejected ||
                              v.claim.status == ClaimStatus.proofPending
                          ? () => _showProof(v)
                          : null,
                    ),
                  if (d.topStudents.isNotEmpty) ...[
                    SectionTitle(l.dashTopStudents),
                    for (final s in d.topStudents)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: InitialsAvatar(s.name),
                        title: Text(s.name),
                        subtitle: Text(s.university),
                        trailing: Pill(
                          l.dashApprovedCount(s.approved),
                          tone: PillTone.green,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          },
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => TreatCard(
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: context.text.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          maxLines: 2,
          style: context.text.labelMedium?.copyWith(color: T.inkSecondary),
        ),
      ],
    ),
  );
}

class _RoiCard extends StatelessWidget {
  const _RoiCard({required this.data});
  final ShopDashboard data;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    Widget cell(String label, String value, String note) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.text.labelMedium?.copyWith(
              color: T.inkInverse.withValues(alpha: 0.85),
            ),
          ),
          Text(
            value,
            style: context.text.headlineSmall?.copyWith(
              color: T.inkInverse,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            note,
            style: context.text.bodySmall?.copyWith(
              color: T.inkInverse.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF6A3F), T.accentHover],
        ),
        borderRadius: BorderRadius.circular(T.radiusLg),
      ),
      child: Row(
        children: [
          cell(l.dashEstReach, '${data.estimatedReach}', l.dashEstReachNote),
          const SizedBox(width: 12),
          cell(
            l.dashEstValue,
            '₺${data.estimatedValueTl}',
            l.dashEstValueNote,
          ),
        ],
      ),
    );
  }
}

class _FeedRow extends StatelessWidget {
  const _FeedRow({required this.view, required this.flash, this.onViewProof});
  final ClaimView view;
  final bool flash;
  final VoidCallback? onViewProof;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final c = view.claim;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: flash ? T.accentSoft : T.card,
        borderRadius: BorderRadius.circular(T.radiusMd),
        border: Border.all(color: flash ? T.accent : T.border),
      ),
      child: Row(
        children: [
          InitialsAvatar(c.studentName, size: 36),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.studentName, style: context.text.titleSmall),
                Text(
                  '${view.offer.title} · ${istanbulDateTime(c.createdAt)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodySmall?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
                if (c.thanksNote != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      '“${c.thanksNote}”',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.bodySmall?.copyWith(
                        color: T.accentInk,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (onViewProof != null)
            IconButton(
              tooltip: l.dashViewProof,
              onPressed: onViewProof,
              icon: const Icon(Icons.image_outlined, color: T.inkSecondary),
            ),
          Pill(c.status.label(l), tone: claimTone(c.status)),
        ],
      ),
    );
  }
}
