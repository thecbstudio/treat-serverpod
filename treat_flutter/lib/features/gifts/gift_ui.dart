import 'package:flutter/material.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../l10n/app_localizations.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// "100", "20.50": liras with kuruş only when there are some.
String formatTl(num tl) =>
    tl == tl.roundToDouble() ? tl.toStringAsFixed(0) : tl.toStringAsFixed(2);

String giftStatusLabel(GiftStatus s, AppLocalizations l) => switch (s) {
  GiftStatus.awaitingPayment => l.giftStatusAwaitingPayment,
  GiftStatus.pending => l.giftStatusPending,
  GiftStatus.redeemed => l.giftStatusRedeemed,
  GiftStatus.cancelled => l.giftStatusCancelled,
  GiftStatus.expired => l.giftStatusExpired,
  GiftStatus.paymentFailed => l.giftStatusFailed,
};

PillTone giftStatusTone(GiftStatus s) => switch (s) {
  GiftStatus.pending => PillTone.accent,
  GiftStatus.redeemed => PillTone.green,
  GiftStatus.awaitingPayment => PillTone.amber,
  _ => PillTone.neutral,
};

/// One gift in a list: place, amount, who it is with, and its state.
class GiftTile extends StatelessWidget {
  const GiftTile({super.key, required this.view, required this.onTap});
  final GiftView view;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final g = view.gift;
    final who = view.viewerIsSender
        ? l.giftTo(g.recipientName)
        : l.giftFrom(g.senderName);
    return TreatCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: T.accentSoft,
              borderRadius: BorderRadius.circular(T.radiusMd),
            ),
            child: const Icon(Icons.card_giftcard_rounded, color: T.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  g.shopName.isEmpty ? '—' : g.shopName,
                  style: context.text.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '$who · ${istanbulDate(g.createdAt)}',
                  style: context.text.bodySmall?.copyWith(
                    color: T.inkSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${g.amountTl} TL',
                style: context.text.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Pill(
                giftStatusLabel(g.status, l),
                tone: giftStatusTone(g.status),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
