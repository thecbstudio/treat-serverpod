import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../ui/widgets.dart';
import 'auth_hero.dart';
import 'demo_box.dart';
import 'onboarding_screen.dart' show RoleTile;

/// First screen: what treat is, then "who are you?" — student or business —
/// before any sign-up form. On a laptop the how-it-works steps and a few
/// photos move into the hero panel.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final wide = context.isWide;
    return AuthScaffold(
      title: l.welcomeTagline,
      subtitle: l.welcomeIntro,
      aside: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Steps(light: true),
          SizedBox(height: 36),
          _Collage(),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!wide) ...[const _Steps(), const SizedBox(height: 8)],
          const DemoBox(),
          Text(l.welcomeWho, style: context.text.titleMedium),
          const SizedBox(height: 10),
          RoleTile(
            icon: Icons.school_outlined,
            title: l.welcomeStudentCta,
            hint: l.welcomeStudentHint,
            onTap: () => context.push('/sign-in?mode=register&role=student'),
          ),
          const SizedBox(height: 10),
          RoleTile(
            icon: Icons.storefront_outlined,
            title: l.welcomeShopCta,
            hint: l.welcomeShopHint,
            onTap: () => context.push('/sign-in?mode=register&role=shop'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l.welcomeHaveAccount,
                style: context.text.bodyMedium?.copyWith(
                  color: T.inkSecondary,
                ),
              ),
              TextButton(
                onPressed: () => context.push('/sign-in?mode=login'),
                child: Text(l.welcomeLogin),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Browse → get scanned → post. [light] = on the persimmon hero panel.
class _Steps extends StatelessWidget {
  const _Steps({this.light = false});
  final bool light;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final steps = [
      (Icons.local_offer_outlined, l.welcomeHow1),
      (Icons.qr_code_2_rounded, l.welcomeHow2),
      (Icons.photo_camera_outlined, l.welcomeHow3),
    ];
    final ink = light ? T.inkInverse : T.ink;
    return Column(
      children: [
        for (final (i, (icon, text)) in steps.indexed) ...[
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: light
                      ? T.inkInverse.withValues(alpha: 0.16)
                      : T.accentSoft,
                  borderRadius: BorderRadius.circular(T.radiusMd),
                ),
                child: Icon(
                  icon,
                  color: light ? T.inkInverse : T.accentInk,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${i + 1}',
                style: context.text.titleMedium?.copyWith(
                  color: light
                      ? T.inkInverse.withValues(alpha: 0.7)
                      : T.inkTertiary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: context.text.bodyLarge?.copyWith(color: ink),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

/// Three tilted "story" photos — the kind of posts students make.
class _Collage extends StatelessWidget {
  const _Collage();

  @override
  Widget build(BuildContext context) {
    const photos = [
      ('assets/cat/coffee.jpg', -0.07),
      ('assets/cat/activity.jpg', 0.03),
      ('assets/cat/dessert.jpg', 0.08),
    ];
    return SizedBox(
      height: 220,
      child: Row(
        children: [
          for (final (path, angle) in photos)
            Expanded(
              child: Transform.rotate(
                angle: angle * math.pi,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(T.radiusLg),
                    border: Border.all(color: T.inkInverse, width: 4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Image.asset(path, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
