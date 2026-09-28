import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// One-tap demo sign-in for judges. Hidden unless the server runs in demo
/// mode. The student side gets a fresh guest account every time; the
/// business side is the shared demo place.
class DemoBox extends StatefulWidget {
  const DemoBox({super.key});

  @override
  State<DemoBox> createState() => _DemoBoxState();
}

class _DemoBoxState extends State<DemoBox> {
  late final Future<bool> _enabled = client.demo.enabled().catchError(
    (_) => false,
  );
  UserRole? _busy;

  Future<void> _signIn(UserRole role) async {
    setState(() => _busy = role);
    try {
      final auth = role == UserRole.student
          ? await client.demo.signInAsGuestStudent()
          : await client.demo.signInAsDemoShop();
      // The router redirects once the session knows the role.
      await client.auth.updateSignedInUser(auth);
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _enabled,
    builder: (context, snap) {
      if (snap.data != true) return const SizedBox.shrink();
      final l = context.l;
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: T.ink,
          borderRadius: BorderRadius.circular(T.radiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.bolt_rounded, color: T.accent, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    l.demoTitle,
                    style: context.text.titleMedium?.copyWith(
                      color: T.inkInverse,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              l.demoHint,
              style: context.text.bodySmall?.copyWith(
                color: T.inkInverse.withValues(alpha: 0.75),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DemoButton(
                    icon: Icons.school_outlined,
                    label: l.demoStudent,
                    busy: _busy == UserRole.student,
                    onPressed: _busy == null
                        ? () => _signIn(UserRole.student)
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _DemoButton(
                    icon: Icons.storefront_outlined,
                    label: l.demoShop,
                    busy: _busy == UserRole.shop,
                    onPressed: _busy == null
                        ? () => _signIn(UserRole.shop)
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class _DemoButton extends StatelessWidget {
  const _DemoButton({
    required this.icon,
    required this.label,
    required this.busy,
    required this.onPressed,
  });
  final IconData icon;
  final String label;
  final bool busy;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => FilledButton.icon(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
    ),
    icon: busy
        ? const SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: T.inkInverse,
            ),
          )
        : Icon(icon, size: 18),
    label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
  );
}
