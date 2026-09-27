import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

PillTone claimTone(ClaimStatus s) => switch (s) {
  ClaimStatus.active => PillTone.accent,
  ClaimStatus.redeemed || ClaimStatus.proofPending => PillTone.amber,
  ClaimStatus.approved => PillTone.green,
  ClaimStatus.rejected => PillTone.red,
  ClaimStatus.expired => PillTone.neutral,
};

/// The student's QR screen. Subscribes to `claim.watch`, so it flips to
/// "Redeemed" the moment the shop scans — no refresh needed.
class ClaimScreen extends StatefulWidget {
  const ClaimScreen({super.key, required this.claimId});
  final int claimId;

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  StreamSubscription<ClaimView>? _sub;
  ClaimView? _view;
  Object? _error;
  bool _reconnecting = false;
  int _retries = 0;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  void _subscribe() {
    _sub?.cancel();
    _sub = client.claim
        .watch(widget.claimId)
        .listen(
          (view) => setState(() {
            _view = view;
            _error = null;
            _reconnecting = false;
            _retries = 0;
          }),
          onError: _onStreamEnded,
          onDone: () => _onStreamEnded(null),
        );
  }

  /// Connection dropped: keep showing the last state and reconnect with
  /// backoff; only surface an error if we never got any data.
  void _onStreamEnded(Object? error) {
    if (!mounted) return;
    if (error is TreatException || (_view == null && _retries >= 2)) {
      setState(() => _error = error ?? 'stream closed');
      return;
    }
    setState(() => _reconnecting = true);
    _retries += 1;
    Future.delayed(Duration(seconds: _retries.clamp(1, 10)), () {
      if (mounted) _subscribe();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final view = _view;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.claimTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: l.back,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/claims'),
        ),
        actions: [
          if (view != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _reconnecting
                  ? Pill(l.claimReconnecting, icon: Icons.sync_rounded)
                  : Pill(l.claimLive, tone: PillTone.green, icon: Icons.circle),
            ),
        ],
      ),
      body: switch ((view, _error)) {
        (null, final Object error) => ErrorView(
          error: error,
          onRetry: () {
            setState(() {
              _error = null;
              _retries = 0;
            });
            _subscribe();
          },
        ),
        (null, _) => const LoadingView(),
        (final ClaimView v, _) => AppWidth(child: _ClaimBody(view: v)),
      },
    );
  }
}

class _ClaimBody extends StatelessWidget {
  const _ClaimBody({required this.view});
  final ClaimView view;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final claim = view.claim;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        Text(view.offer.title, style: context.text.titleLarge),
        Text(
          view.shop.name,
          style: context.text.titleMedium?.copyWith(color: T.inkSecondary),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Pill(claim.status.label(l), tone: claimTone(claim.status)),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: KeyedSubtree(
            key: ValueKey(claim.status),
            child: switch (claim.status) {
              ClaimStatus.active => _ActiveQr(claim: claim),
              ClaimStatus.expired => EmptyView(
                icon: Icons.timer_off_outlined,
                title: l.claimExpired,
                hint: l.claimExpiredBody,
              ),
              _ => _Redeemed(view: view),
            },
          ),
        ),
      ],
    );
  }
}

class _ActiveQr extends StatelessWidget {
  const _ActiveQr({required this.claim});
  final Claim claim;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TreatCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              QrImageView(
                data: 'treat:${claim.id}:${claim.code}',
                size: 240,
                backgroundColor: T.card,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: T.ink,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: T.ink,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l.claimManualCode,
                style: context.text.labelMedium?.copyWith(
                  color: T.inkSecondary,
                ),
              ),
              const SizedBox(height: 4),
              SelectableText(
                claim.code,
                style: context.text.headlineMedium?.copyWith(
                  letterSpacing: 6,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _Countdown(expiresAt: claim.expiresAt),
        const SizedBox(height: 14),
        Notice(l.claimShowThis, tone: PillTone.accent, icon: Icons.storefront),
      ],
    );
  }
}

class _Countdown extends StatefulWidget {
  const _Countdown({required this.expiresAt});
  final DateTime expiresAt;

  @override
  State<_Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<_Countdown> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var left = widget.expiresAt.difference(DateTime.now().toUtc());
    if (left.isNegative) left = Duration.zero;
    String two(int n) => n.toString().padLeft(2, '0');
    final text =
        '${left.inHours}:${two(left.inMinutes % 60)}:${two(left.inSeconds % 60)}';
    final urgent = left < const Duration(minutes: 10);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.timer_outlined,
          color: urgent ? T.red : T.inkSecondary,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          '${context.l.claimExpiresIn} ',
          style: context.text.bodyLarge?.copyWith(color: T.inkSecondary),
        ),
        Text(
          text,
          style: context.text.titleLarge?.copyWith(
            color: urgent ? T.red : T.ink,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

class _Redeemed extends StatelessWidget {
  const _Redeemed({required this.view});
  final ClaimView view;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final claim = view.claim;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TreatCard(
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: T.greenSoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: T.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.claimRedeemed, style: context.text.titleMedium),
                    if (claim.redeemedAt != null)
                      Text(
                        l.claimRedeemedAt(istanbulDateTime(claim.redeemedAt!)),
                        style: context.text.bodySmall?.copyWith(
                          color: T.inkSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SectionTitle(l.claimNextStep),
        Text(l.claimProofExplain, style: context.text.bodyMedium),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in view.offer.proofTypes)
              Pill(p.label(l), icon: Icons.photo_camera_outlined),
          ],
        ),
        const SizedBox(height: 14),
        // Proof upload + AI verification land in M3.
        Notice(l.claimProofSoon),
      ],
    );
  }
}
