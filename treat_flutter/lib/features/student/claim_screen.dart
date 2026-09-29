import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import 'proof_form.dart';

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
            final before = _view?.claim.status;
            final after = view.claim.status;
            if (before != null &&
                before != after &&
                (after == ClaimStatus.approved ||
                    after == ClaimStatus.rejected)) {
              appSession.refresh();
            }
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
        title: Text(
          view == null || view.claim.status == ClaimStatus.active
              ? l.claimTitle
              : l.claimTitleTreat,
        ),
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
              ClaimStatus.redeemed => _Redeemed(view: view),
              ClaimStatus.proofPending => _Verdict(
                icon: Icons.hourglass_top_rounded,
                tone: PillTone.amber,
                title: l.claimProofPending,
                body: l.claimProofPendingBody,
                busy: true,
              ),
              ClaimStatus.approved => _Approved(view: view),
              ClaimStatus.rejected => _Rejected(view: view),
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
        if (claim.verdictReason == 'verify_failed') ...[
          Notice(l.proofVerifyFailed),
          const SizedBox(height: 12),
        ],
        ProofForm(
          claimId: claim.id!,
          proofTypes: view.offer.proofTypes,
          shopName: view.shop.name,
          instagramHandle: view.shop.instagramHandle,
          submitLabel: l.proofSubmit,
        ),
      ],
    );
  }
}

class _Verdict extends StatelessWidget {
  const _Verdict({
    required this.icon,
    required this.tone,
    required this.title,
    required this.body,
    this.busy = false,
  });

  final IconData icon;
  final PillTone tone;
  final String title;
  final String body;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      PillTone.green => (T.greenSoft, T.green),
      PillTone.red => (T.redSoft, T.red),
      _ => (T.amberSoft, T.amber),
    };
    return TreatCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: busy
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: CircularProgressIndicator(color: fg, strokeWidth: 3),
                  )
                : Icon(icon, color: fg, size: 42),
          ),
          const SizedBox(height: 14),
          Text(title, style: context.text.titleLarge),
          const SizedBox(height: 6),
          Text(
            body,
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(color: T.inkSecondary),
          ),
        ],
      ),
    );
  }
}

class _Rejected extends StatelessWidget {
  const _Rejected({required this.view});
  final ClaimView view;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final claim = view.claim;
    final strikes = appSession.me?.student?.strikes ?? 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Verdict(
          icon: Icons.close_rounded,
          tone: PillTone.red,
          title: l.claimRejected,
          body: l.claimRejectedBody(strikes, 3),
        ),
        const SizedBox(height: 12),
        if (claim.verdictReason == 'verify_failed')
          Notice(l.proofVerifyFailed)
        else
          Notice(
            rejectReasonText(claim.verdictReason, l),
            tone: PillTone.red,
            icon: Icons.error_outline,
          ),
        SectionTitle(l.appealTitle),
        if (claim.appealed)
          Text(l.appealUsed, style: context.text.bodyMedium)
        else ...[
          Text(l.appealExplain, style: context.text.bodyMedium),
          const SizedBox(height: 12),
          ProofForm(
            claimId: claim.id!,
            proofTypes: view.offer.proofTypes,
            shopName: view.shop.name,
            instagramHandle: view.shop.instagramHandle,
            submitLabel: l.appealSubmit,
          ),
        ],
      ],
    );
  }
}

class _Approved extends StatelessWidget {
  const _Approved({required this.view});
  final ClaimView view;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _Verdict(
              icon: Icons.celebration_outlined,
              tone: PillTone.green,
              title: l.claimApproved,
              body: l.claimApprovedBody,
            ),
            const Positioned.fill(child: IgnorePointer(child: Confetti())),
          ],
        ),
        const SizedBox(height: 16),
        _ThanksCard(view: view),
      ],
    );
  }
}

class _ThanksCard extends StatefulWidget {
  const _ThanksCard({required this.view});
  final ClaimView view;

  @override
  State<_ThanksCard> createState() => _ThanksCardState();
}

class _ThanksCardState extends State<_ThanksCard> {
  late final _note = TextEditingController(text: widget.view.claim.thanksNote);
  late bool _share = widget.view.claim.shareOnWall;
  late bool _sent = widget.view.claim.thanksNote != null;
  bool _busy = false;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() => _busy = true);
    try {
      await client.claim.thank(widget.view.claim.id!, _note.text, _share);
      if (!mounted) return;
      setState(() => _sent = true);
      context.toast(context.l.thanksSent);
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final shop = widget.view.shop.name;
    return TreatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite_border_rounded, color: T.accent),
              const SizedBox(width: 8),
              Text(l.thanksTitle, style: context.text.titleMedium),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _note,
            maxLength: 280,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(hintText: l.thanksHint(shop)),
          ),
          // Demo samples are someone else's screenshot: the server never
          // shows them on a wall, so don't offer it.
          if (!widget.view.sampleProof)
            CheckboxListTile(
              value: _share,
              onChanged: (v) => setState(() => _share = v ?? false),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: T.accent,
              title: Text(l.proofShareOnWall(shop)),
            ),
          FilledButton(
            onPressed: _busy ? null : _send,
            child: Text(_sent ? l.thanksUpdate : l.thanksSend),
          ),
        ],
      ),
    );
  }
}

/// One-shot confetti burst in the brand colours.
class Confetti extends StatefulWidget {
  const Confetti({super.key});

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  late final _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..forward();
  final _pieces = List.generate(46, (i) => _Piece(math.Random(i)));

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _c,
    builder: (context, _) =>
        CustomPaint(painter: _ConfettiPainter(_pieces, _c.value)),
  );
}

class _Piece {
  _Piece(math.Random r)
    : angle = -math.pi / 2 + (r.nextDouble() - 0.5) * math.pi * 0.9,
      speed = 0.45 + r.nextDouble() * 0.55,
      spin = (r.nextDouble() - 0.5) * 14,
      color = const [
        T.accent,
        T.gold,
        T.green,
        T.red,
        T.accentHover,
      ][r.nextInt(5)],
      size = 5 + r.nextDouble() * 5;

  final double angle;
  final double speed;
  final double spin;
  final Color color;
  final double size;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.pieces, this.t);
  final List<_Piece> pieces;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    if (t >= 1) return;
    final origin = Offset(size.width / 2, size.height * 0.35);
    final reach = size.width * 0.75;
    for (final p in pieces) {
      final d = reach * p.speed * t;
      final pos =
          origin +
          Offset(math.cos(p.angle) * d, math.sin(p.angle) * d) +
          Offset(0, 260 * t * t); // gravity
      final paint = Paint()..color = p.color.withValues(alpha: 1 - t);
      canvas
        ..save()
        ..translate(pos.dx, pos.dy)
        ..rotate(p.spin * t)
        ..drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size,
            height: p.size * 0.55,
          ),
          paint,
        )
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.t != t;
}
