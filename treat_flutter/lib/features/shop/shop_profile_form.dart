import 'package:flutter/material.dart';
import 'package:treat_client/treat_client.dart';

import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Business profile fields; used for onboarding and later edits.
class ShopProfileForm extends StatefulWidget {
  const ShopProfileForm({
    super.key,
    this.initial,
    required this.submitLabel,
    required this.onSubmit,
    this.onBack,
  });

  final Shop? initial;
  final String submitLabel;
  final Future<void> Function(ShopInput input) onSubmit;
  final VoidCallback? onBack;

  @override
  State<ShopProfileForm> createState() => _ShopProfileFormState();
}

class _ShopProfileFormState extends State<ShopProfileForm> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.initial?.name);
  late final _district = TextEditingController(text: widget.initial?.district);
  late final _address = TextEditingController(text: widget.initial?.address);
  late final _bio = TextEditingController(text: widget.initial?.bio);
  late final _instagram = TextEditingController(
    text: widget.initial?.instagramHandle,
  );
  late OfferCategory _category =
      widget.initial?.category ?? OfferCategory.coffee;
  bool _busy = false;

  @override
  void dispose() {
    for (final c in [_name, _district, _address, _bio, _instagram]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await widget.onSubmit(
        ShopInput(
          name: _name.text,
          category: _category,
          district: _district.text,
          address: _address.text,
          bio: _bio.text,
          instagramHandle: _instagram.text.trim().isEmpty
              ? null
              : _instagram.text,
        ),
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
    final editing = widget.initial != null;
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _name,
            decoration: InputDecoration(labelText: l.fieldShopName),
            maxLength: 60,
            validator: required,
          ),
          const SizedBox(height: 8),
          // Offers copy the category, so it's fixed after onboarding.
          if (!editing) ...[
            Text(l.fieldCategory, style: context.text.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in OfferCategory.values)
                  ChoiceChip(
                    label: Text(c.label(l)),
                    selected: _category == c,
                    labelStyle: TextStyle(
                      color: _category == c ? Colors.white : null,
                      fontWeight: FontWeight.w700,
                    ),
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          TextFormField(
            controller: _district,
            decoration: InputDecoration(labelText: l.fieldDistrict),
            maxLength: 60,
            validator: required,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _address,
            decoration: InputDecoration(labelText: l.fieldAddress),
            maxLength: 120,
            validator: required,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _bio,
            decoration: InputDecoration(labelText: l.fieldBio),
            maxLength: 300,
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _instagram,
            decoration: InputDecoration(
              labelText: l.fieldInstagram,
              helperText: l.fieldInstagramHint,
              prefixText: '@',
            ),
            maxLength: 31,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _busy ? null : _submit,
            child: _busy
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : Text(widget.submitLabel),
          ),
          if (widget.onBack != null)
            TextButton(onPressed: widget.onBack, child: Text(l.back)),
        ],
      ),
    );
  }
}
