import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../ui/widgets.dart';

/// Persimmon hero with the wordmark, a white card overlapping it below.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.showBack = false,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      child: Stack(
        children: [
          const _Hero(),
          SafeArea(
            child: AppWidth(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48,
                      child: showBack
                          ? IconButton(
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: const Icon(Icons.arrow_back_rounded),
                              color: T.inkInverse,
                              tooltip: context.l.back,
                            )
                          : null,
                    ),
                    const Wordmark(color: T.inkInverse, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: context.text.headlineMedium?.copyWith(
                        color: T.inkInverse,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle!,
                        style: context.text.bodyLarge?.copyWith(
                          color: T.inkInverse.withValues(alpha: 0.88),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    TreatCard(
                      padding: const EdgeInsets.all(20),
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) => Container(
    height: 300,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEF6A3F), T.accent, T.accentHover],
      ),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
    ),
    child: CustomPaint(painter: _DotsPainter(), size: Size.infinite),
  );
}

/// Soft confetti dots — a hint of "treat" without emoji.
class _DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x1FFFFFFF);
    const dots = [
      (0.08, 0.18, 28.0),
      (0.86, 0.12, 44.0),
      (0.72, 0.55, 18.0),
      (0.18, 0.72, 12.0),
      (0.94, 0.78, 26.0),
      (0.45, 0.08, 10.0),
    ];
    for (final (x, y, r) in dots) {
      canvas.drawCircle(Offset(size.width * x, size.height * y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Wordmark extends StatelessWidget {
  const Wordmark({super.key, this.color = T.accent, this.size = 28});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Text(
    'treat.',
    style: context.text.displaySmall?.copyWith(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.2,
      height: 1,
    ),
  );
}
