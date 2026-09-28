import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../ui/widgets.dart';
import 'auth_hero.dart';
import 'onboarding_screen.dart' show RoleTile;

/// First screen: what treat is, then "who are you?" — student or business —
/// before any sign-up form.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final steps = [
      (Icons.local_offer_outlined, l.welcomeHow1),
      (Icons.qr_code_2_rounded, l.welcomeHow2),
      (Icons.photo_camera_outlined, l.welcomeHow3),
    ];
    return AuthScaffold(
      title: l.welcomeTagline,
      subtitle: l.welcomeIntro,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, (icon, text)) in steps.indexed) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: T.accentSoft,
                    borderRadius: BorderRadius.circular(T.radiusMd),
                  ),
                  child: Icon(icon, color: T.accentInk, size: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  '${i + 1}',
                  style: context.text.titleMedium?.copyWith(
                    color: T.inkTertiary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(text, style: context.text.bodyLarge)),
              ],
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 8),
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
          Text(
            l.welcomeDemoHint,
            textAlign: TextAlign.center,
            style: context.text.bodySmall?.copyWith(color: T.inkTertiary),
          ),
        ],
      ),
    );
  }
}
