import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import 'auth_hero.dart';

/// Serverpod's email sign-in flow (register → code → password, or login),
/// inside our hero + card. The router moves on once auth state changes.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.register});

  final bool register;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return AuthScaffold(
      showBack: true,
      title: register ? l.authRegisterTitle : l.authLoginTitle,
      subtitle: register ? l.authEduHint : null,
      child: EmailSignInWidget(
        client: client,
        startScreen: register
            ? EmailFlowScreen.startRegistration
            : EmailFlowScreen.login,
        onError: (error) => context.toast(errorMessage(error, l)),
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
