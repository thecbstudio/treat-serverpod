import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../account/account_actions.dart';
import 'auth_hero.dart';

/// Serverpod's email sign-in flow (register → code → password, or login),
/// inside our hero + card. The router moves on once auth state changes.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.register, this.role});

  final bool register;

  /// Picked on the welcome screen; onboarding continues with it.
  final UserRole? role;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    if (role != null) appSession.intendedRole = role;
    final shop = role == UserRole.shop;
    return AuthScaffold(
      showBack: true,
      title: !register
          ? l.authLoginTitle
          : shop
          ? l.authShopRegisterTitle
          : l.authRegisterTitle,
      subtitle: !register
          ? null
          : shop
          ? l.authShopHint
          : l.authEduHint,
      child: EmailSignInWidget(
        client: client,
        startScreen: register
            ? EmailFlowScreen.startRegistration
            : EmailFlowScreen.login,
        onError: (error) => context.toast(errorMessage(error, l)),
        // Sign-up asks to accept both (Serverpod's built-in checkbox).
        onTermsAndConditionsPressed: () => openWebPage('/terms'),
        onPrivacyPolicyPressed: () => openWebPage('/privacy'),
      ),
    );
  }
}

/// Shown while the app restores the session or loads the profile.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: T.accent,
    body: Center(child: Wordmark(color: T.inkInverse, size: 44)),
  );
}
