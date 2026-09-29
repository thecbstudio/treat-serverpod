import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Rebuilds every second with the current time (countdowns).
class Ticking extends StatefulWidget {
  const Ticking({super.key, required this.builder});
  final Widget Function(BuildContext context, DateTime now) builder;

  @override
  State<Ticking> createState() => _TickingState();
}

class _TickingState extends State<Ticking> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, DateTime.now().toUtc());
}

/// Discover's "Live drops" row. Subscribes to `offer.watchDrops`, so new
/// drops appear and stock counts drop live. Hidden while there are none.
class LiveDropsStrip extends StatefulWidget {
  const LiveDropsStrip({super.key});

  @override
  State<LiveDropsStrip> createState() => _LiveDropsStripState();
}

class _LiveDropsStripState extends State<LiveDropsStrip> {
  StreamSubscription<List<OfferCard>>? _sub;
  List<OfferCard> _drops = const [];
  int _retries = 0;

  @override
  void initState() {
    super.initState();
    _listen();
  }

  void _listen() {
    _sub?.cancel();
    _sub = client.offer.watchDrops().listen(
      (drops) {
        _retries = 0;
        if (mounted) setState(() => _drops = drops);
      },
      onError: (_) => _reconnect(),
      onDone: _reconnect,
    );
  }

  void _reconnect() {
    if (!mounted) return;
    _retries += 1;
    Future.delayed(Duration(seconds: _retries.clamp(1, 15)), () {
      if (mounted) _listen();
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
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.topCenter,
      child: _drops.isEmpty
          ? const SizedBox(width: double.infinity)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const LivePulse(),
                    const SizedBox(width: 8),
                    Text(l.dropsTitle, style: context.text.titleLarge),
                  ],
                ),
                Text(
                  l.dropsSubtitle,
                  style: context.text.bodySmall?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 176,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _drops.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, i) => DropCard(
                      card: _drops[i],
                      onTap: () => context.push('/offer/${_drops[i].offer.id}'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}

/// A pulsing red dot for "live".
class LivePulse extends StatefulWidget {
  const LivePulse({super.key, this.size = 10});
  final double size;

  @override
  State<LivePulse> createState() => _LivePulseState();
}

class _LivePulseState extends State<LivePulse>
    with SingleTickerProviderStateMixin {
  late final _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: widget.size * 2.2,
    child: AnimatedBuilder(
      animation: _c,
      builder: (context, _) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: widget.size * (1 + 1.2 * _c.value),
            height: widget.size * (1 + 1.2 * _c.value),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: T.red.withValues(alpha: 0.35 * (1 - _c.value)),
            ),
          ),
          Container(
            width: widget.size,
            height: widget.size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: T.red,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Stock bar + "x of y left".
class DropStock extends StatelessWidget {
  const DropStock({super.key, required this.card, this.light = false});
  final OfferCard card;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final total = card.offer.totalCap ?? 0;
    final left = (total - card.claimedTotal).clamp(0, total);
    final fg = light ? T.inkInverse : T.ink;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(end: total == 0 ? 0 : left / total),
          duration: const Duration(milliseconds: 500),
          builder: (context, v, _) => ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: v,
              minHeight: 6,
              color: light ? T.inkInverse : T.accent,
              backgroundColor: (light ? T.inkInverse : T.accent).withValues(
                alpha: 0.2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          left == 0 ? context.l.dropSoldOut : context.l.dropLeft(left, total),
          style: context.text.labelMedium?.copyWith(
            color: fg,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class DropCard extends StatelessWidget {
  const DropCard({super.key, required this.card, this.onTap});
  final OfferCard card;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final offer = card.offer;
    return SizedBox(
      width: 250,
      child: Material(
        borderRadius: BorderRadius.circular(T.radiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(shopPhoto(card.shop)),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.45),
                  BlendMode.darken,
                ),
              ),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: T.red,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        l.dropBadge,
                        style: context.text.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Ticking(
                      builder: (context, now) => Text(
                        l.dropEndsIn(countdown(offer.endsAt!.difference(now))),
                        style: context.text.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  card.shop.name,
                  style: context.text.labelMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  offer.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                DropStock(card: card, light: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
