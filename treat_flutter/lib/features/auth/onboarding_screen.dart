import 'package:flutter/material.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../shop/shop_profile_form.dart';
import 'auth_hero.dart';

/// First sign-in: pick a role, then fill the matching profile.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  UserRole? _role;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final email = appSession.me?.email ?? '';
    return AuthScaffold(
      title: switch (_role) {
        null => l.onboardingTitle,
        UserRole.student => l.studentFormTitle,
        UserRole.shop => l.shopFormTitle,
      },
      subtitle: l.onboardingSignedInAs(email),
      child: switch (_role) {
        null => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l.onboardingBody, style: context.text.titleMedium),
            const SizedBox(height: 14),
            _RoleTile(
              icon: Icons.school_outlined,
              title: l.onboardingStudent,
              hint: l.onboardingStudentHint,
              onTap: () => setState(() => _role = UserRole.student),
            ),
            const SizedBox(height: 10),
            _RoleTile(
              icon: Icons.storefront_outlined,
              title: l.onboardingShop,
              hint: l.onboardingShopHint,
              onTap: () => setState(() => _role = UserRole.shop),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: appSession.signOut,
              child: Text(l.logout),
            ),
          ],
        ),
        UserRole.student => _StudentForm(
          email: email,
          onBack: () => setState(() => _role = null),
        ),
        UserRole.shop => ShopProfileForm(
          submitLabel: l.createProfile,
          onBack: () => setState(() => _role = null),
          onSubmit: (input) async =>
              appSession.apply(await client.profile.createShop(input)),
        ),
      },
    );
  }
}

class _RoleTile extends StatelessWidget {
  const _RoleTile({
    required this.icon,
    required this.title,
    required this.hint,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: T.bg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(T.radiusMd),
      side: const BorderSide(color: T.border),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: T.accent, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.text.titleMedium),
                  Text(
                    hint,
                    style: context.text.bodyMedium?.copyWith(
                      color: T.inkSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: T.inkTertiary),
          ],
        ),
      ),
    ),
  );
}

class _StudentForm extends StatefulWidget {
  const _StudentForm({required this.email, required this.onBack});
  final String email;
  final VoidCallback onBack;

  @override
  State<_StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<_StudentForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _university = TextEditingController();
  bool _busy = false;

  static final _edu = RegExp(
    r'@(?:[a-z0-9-]+\.)*edu(?:\.[a-z]{2})?$',
    caseSensitive: false,
  );

  @override
  void dispose() {
    _name.dispose();
    _university.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      appSession.apply(
        await client.profile.createStudent(_name.text, _university.text),
      );
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l.fieldRequired : null;
    final isEdu = _edu.hasMatch(widget.email);
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Notice(
            isEdu ? l.eduDetected : l.nonEduNote,
            tone: isEdu ? PillTone.green : PillTone.amber,
            icon: isEdu ? Icons.verified_outlined : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            decoration: InputDecoration(labelText: l.fieldName),
            textCapitalization: TextCapitalization.words,
            maxLength: 60,
            validator: required,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _university,
            decoration: InputDecoration(
              labelText: l.fieldUniversity,
              hintText: l.fieldUniversityHint,
            ),
            textCapitalization: TextCapitalization.words,
            maxLength: 80,
            validator: required,
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _busy ? null : _submit,
            child: _busy
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : Text(l.createProfile),
          ),
          TextButton(onPressed: widget.onBack, child: Text(l.back)),
        ],
      ),
    );
  }
}
