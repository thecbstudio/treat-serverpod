import 'package:flutter/material.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import '../account/account_actions.dart';
import 'reputation_tools.dart';
import 'shop_profile_form.dart';

class ShopProfileScreen extends StatelessWidget {
  const ShopProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final me = appSession.me;
    final shop = me?.shop;
    if (me == null || shop == null) return const LoadingView();
    return Scaffold(
      body: SafeArea(
        child: AppWidth(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l.shopEditTitle, style: context.text.headlineMedium),
              const SizedBox(height: 4),
              Row(
                children: [
                  Pill(shop.category.label(l), tone: PillTone.accent),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      me.email,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.bodyMedium?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ReputationTools(shop: shop),
              const SizedBox(height: 16),
              TreatCard(
                child: ShopProfileForm(
                  initial: shop,
                  submitLabel: l.save,
                  onSubmit: (input) async {
                    final updated = await client.profile.updateShop(input);
                    appSession.apply(me.copyWith(shop: updated));
                    if (context.mounted) context.toast(l.saved);
                  },
                ),
              ),
              SectionTitle(l.settingsLegal),
              const LegalLinks(),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: appSession.signOut,
                icon: const Icon(Icons.logout_rounded),
                label: Text(l.logout),
              ),
              const SizedBox(height: 8),
              const Align(child: DeleteAccountButton(isShop: true)),
            ],
          ),
        ),
      ),
    );
  }
}
