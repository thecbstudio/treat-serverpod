import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../account/account_actions.dart';

/// Guests are recognised by this university on the server.
const _guestUniversity = 'Demo University';

/// Student settings: name and university, privacy/terms, sign out, delete.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(
    text: appSession.me?.student?.name,
  );
  late final _university = TextEditingController(
    text: appSession.me?.student?.university,
  );
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _university.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      appSession.apply(
        await client.profile.updateStudent(_name.text, _university.text),
      );
      if (mounted) context.toast(context.l.saved);
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final me = appSession.me;
    final student = me?.student;
    if (me == null || student == null) return const LoadingView();
    final guest = student.university == _guestUniversity;
    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l.fieldRequired : null;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.settingsTitle),
        leading: IconButton(
          onPressed: () => context.canPop() ? context.pop() : context.go('/me'),
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: l.back,
        ),
      ),
      body: SafeArea(
        child: AppWidth(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SectionTitle(l.settingsProfile),
              TreatCard(
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                        enabled: !guest,
                        decoration: InputDecoration(
                          labelText: l.fieldUniversity,
                          helperText: guest ? l.settingsGuestUniversity : null,
                          helperMaxLines: 2,
                        ),
                        textCapitalization: TextCapitalization.words,
                        maxLength: 80,
                        validator: required,
                        onFieldSubmitted: (_) => _save(),
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: _busy ? null : _save,
                        child: Text(l.save),
                      ),
                    ],
                  ),
                ),
              ),
              SectionTitle(l.settingsLegal),
              const LegalLinks(),
              SectionTitle(l.settingsAccount),
              // One-tap demo guests have no e-mail login, but a gift address.
              if (me.email.isNotEmpty) ...[
                Text(
                  l.settingsSignedInAs(me.email),
                  style: context.text.bodyMedium?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              TreatCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.giftYourAddress,
                      style: context.text.labelLarge?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      student.email,
                      style: context.text.titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: appSession.signOut,
                icon: const Icon(Icons.logout_rounded),
                label: Text(l.logout),
              ),
              const SizedBox(height: 8),
              const Align(child: DeleteAccountButton(isShop: false)),
            ],
          ),
        ),
      ),
    );
  }
}
