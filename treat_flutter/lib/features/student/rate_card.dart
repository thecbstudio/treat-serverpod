import 'package:flutter/material.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// "How was your visit?" — shown once the place scanned the code. Stars are
/// public on the place page (labelled as a verified visit with a free
/// treat), the short review too; the private note only reaches the place.
/// The rating never affects the treat.
class RateCard extends StatefulWidget {
  const RateCard({super.key, required this.view});
  final ClaimView view;

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  late int _stars = widget.view.claim.rating ?? 0;
  late final _review = TextEditingController(text: widget.view.claim.review);
  late final _note = TextEditingController(
    text: widget.view.claim.privateNote,
  );
  late bool _editing = widget.view.claim.rating == null;
  bool _busy = false;

  @override
  void dispose() {
    _review.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _busy = true);
    try {
      await client.claim.rate(
        widget.view.claim.id!,
        _stars,
        review: _review.text,
        privateNote: _note.text,
      );
      if (!mounted) return;
      setState(() => _editing = false);
      context.toast(context.l.rateThanks);
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
    final review = widget.view.claim.review;
    return TreatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.star_outline_rounded, color: T.accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _editing ? l.rateTitle(shop) : l.rateDone,
                  style: context.text.titleMedium,
                ),
              ),
              if (!_editing)
                TextButton(
                  onPressed: () => setState(() => _editing = true),
                  child: Text(l.rateEdit),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Stars(
            value: _stars,
            size: 36,
            onChanged: _editing && !_busy
                ? (v) => setState(() => _stars = v)
                : null,
          ),
          if (!_editing && review != null && review.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '“$review”',
                style: context.text.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          if (_editing) ...[
            const SizedBox(height: 10),
            TextField(
              controller: _review,
              maxLength: 280,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(hintText: l.rateReviewHint),
            ),
            TextField(
              controller: _note,
              maxLength: 280,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: l.ratePrivateHint(shop),
                prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18),
              ),
            ),
            Text(
              l.rateDisclaimer,
              style: context.text.bodySmall?.copyWith(color: T.inkSecondary),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: _stars == 0 || _busy ? null : _save,
              child: Text(l.rateSave),
            ),
          ],
        ],
      ),
    );
  }
}

/// 1–5 stars; tappable when [onChanged] is set.
class Stars extends StatelessWidget {
  const Stars({super.key, required this.value, this.size = 18, this.onChanged});
  final int value;
  final double size;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 1; i <= 5; i++)
        if (onChanged == null)
          Icon(
            i <= value ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: T.star,
          )
        else
          IconButton(
            onPressed: () => onChanged!(i),
            iconSize: size,
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            tooltip: '$i',
            icon: Icon(
              i <= value ? Icons.star_rounded : Icons.star_outline_rounded,
              color: T.star,
            ),
          ),
    ],
  );
}

/// "★ 4.7 (23)" — a place's treat score, or nothing without ratings.
class ScoreBadge extends StatelessWidget {
  const ScoreBadge({super.key, required this.rating, this.light = false});
  final ShopRating? rating;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final r = rating;
    if (r == null || r.count == 0) return const SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 16, color: T.star),
        const SizedBox(width: 2),
        Text(
          '${r.average.toStringAsFixed(1)} (${r.count})',
          style: context.text.labelMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: light ? T.inkInverse : T.ink,
          ),
        ),
      ],
    );
  }
}
