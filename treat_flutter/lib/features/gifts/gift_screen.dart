import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import 'gift_ui.dart';

/// One gift. The recipient sees the QR to show at the counter; the sender
/// sees its state and can take it back. After paying on iyzico the browser
/// lands here with `?pay=ok|failed|unknown` and we confirm with the server.
class GiftScreen extends StatefulWidget {
  const GiftScreen({super.key, required this.giftId, this.payResult});
  final int giftId;
  final String? payResult;

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  GiftView? _view;
  Object? _error;
  Timer? _poll;
  int _polls = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      var view = await client.gift.get(widget.giftId);
      // Back from the payment page, or an unfinished payment of ours: ask
      // iyzico (a few times, it can lag behind the redirect).
      if (view.viewerIsSender &&
          view.gift.status == GiftStatus.awaitingPayment) {
        view = await client.gift.confirm(widget.giftId);
        if (view.gift.status == GiftStatus.awaitingPayment &&
            widget.payResult != null) {
          _watch();
        }
      }
      if (mounted) {
        setState(() {
          _view = view;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  void _watch() {
    _poll?.cancel();
    _poll = Timer.periodic(const Duration(seconds: 3), (t) async {
      if (++_polls > 10) return t.cancel();
      try {
        final v = await client.gift.confirm(widget.giftId);
        if (!mounted) return;
        setState(() => _view = v);
        if (v.gift.status != GiftStatus.awaitingPayment) t.cancel();
      } catch (_) {
        // Try again on the next tick.
      }
    });
  }

  Future<void> _cancel() async {
    final l = context.l;
    final sure = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.giftCancelTitle),
        content: Text(l.giftCancelBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l.back),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l.giftCancel),
          ),
        ],
      ),
    );
    if (sure != true) return;
    try {
      final v = await client.gift.cancel(widget.giftId);
      if (!mounted) return;
      setState(() => _view = v);
      context.toast(l.giftCancelDone);
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, l));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final view = _view;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.giftDetailTitle),
        leading: IconButton(
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/gifts'),
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: l.back,
        ),
      ),
      body: SafeArea(
        child: switch ((view, _error)) {
          (null, final Object e) => ErrorView(error: e, onRetry: _load),
          (null, _) => const LoadingView(),
          (final GiftView v, _) => RefreshIndicator(
            color: T.accent,
            onRefresh: _load,
            child: AppWidth(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: _content(context, v),
              ),
            ),
          ),
        },
      ),
    );
  }

  List<Widget> _content(BuildContext context, GiftView v) {
    final l = context.l;
    final g = v.gift;
    final pay = widget.payResult;
    return [
      if (pay != null && g.status == GiftStatus.awaitingPayment)
        TreatCard(
          child: Row(
            children: [
              const SizedBox.square(
                dimension: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  pay == 'unknown' ? l.giftPayUnknown : l.giftConfirming,
                ),
              ),
            ],
          ),
        ),
      if (pay == 'ok' && g.status == GiftStatus.pending && v.viewerIsSender)
        Notice(l.giftPaidOk, tone: PillTone.green, icon: Icons.check_circle),
      if (g.status == GiftStatus.paymentFailed ||
          (pay == 'failed' && g.status == GiftStatus.awaitingPayment))
        Notice(l.giftPayFailed, tone: PillTone.red, icon: Icons.error_outline),
      const SizedBox(height: 12),
      TreatCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    g.shopName.isEmpty ? '—' : g.shopName,
                    style: context.text.titleLarge,
                  ),
                ),
                Pill(
                  giftStatusLabel(g.status, l),
                  tone: giftStatusTone(g.status),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${g.amountTl} TL · ${v.viewerIsSender ? l.giftTo(g.recipientName) : l.giftFrom(g.senderName)}',
                style: context.text.bodyMedium?.copyWith(
                  color: T.inkSecondary,
                ),
              ),
            ),
            if (g.message != null) ...[
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('“${g.message}”', style: context.text.bodyLarge),
              ),
            ],
            if (g.code != null && g.status == GiftStatus.pending) ...[
              const SizedBox(height: 20),
              QrImageView(
                data: 'GIFT:${g.id}:${g.code}',
                size: 220,
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
              const SizedBox(height: 8),
              SelectableText(
                g.code!,
                style: context.text.headlineMedium?.copyWith(letterSpacing: 8),
              ),
              const SizedBox(height: 6),
              Text(
                l.giftShowQr(g.shopName),
                style: context.text.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (g.expiresAt != null)
                Text(
                  l.giftValidUntil(istanbulDate(g.expiresAt!)),
                  style: context.text.bodySmall?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                l.giftReceivedNote,
                style: context.text.bodySmall?.copyWith(color: T.inkSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
      const SizedBox(height: 12),
      if (v.viewerIsSender && g.status == GiftStatus.pending) ...[
        Text(
          l.giftWaitingNote(
            g.recipientName,
            g.shopName,
            istanbulDate(g.expiresAt!),
          ),
          style: context.text.bodyMedium?.copyWith(color: T.inkSecondary),
        ),
        const SizedBox(height: 12),
      ],
      if (g.status == GiftStatus.redeemed)
        Notice(
          l.giftRedeemedNote(g.shopName),
          tone: PillTone.green,
          icon: Icons.check_circle_outline,
        ),
      if (v.viewerIsSender &&
          (g.status == GiftStatus.cancelled || g.status == GiftStatus.expired))
        Notice(
          v.refundPending ? l.giftRefundPending : l.giftRefunded,
          tone: v.refundPending ? PillTone.amber : PillTone.green,
          icon: Icons.undo_rounded,
        ),
      if (v.viewerIsSender &&
          (g.status == GiftStatus.pending ||
              g.status == GiftStatus.awaitingPayment)) ...[
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _cancel,
          icon: const Icon(Icons.undo_rounded),
          label: Text(l.giftCancel),
        ),
      ],
    ];
  }
}
