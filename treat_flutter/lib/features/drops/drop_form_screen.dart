import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Business: start a drop. Pops `true` when started.
class DropFormScreen extends StatefulWidget {
  const DropFormScreen({super.key});

  @override
  State<DropFormScreen> createState() => _DropFormScreenState();
}

class _DropFormScreenState extends State<DropFormScreen> {
  static const _durations = [15, 30, 45, 60, 90];

  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  int _quantity = 5;
  int _minutes = 30;
  final Set<ProofType> _proofs = {ProofType.igStory};
  bool _busy = false;

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate() || _proofs.isEmpty) return;
    setState(() => _busy = true);
    try {
      await client.shopOffers.startDrop(
        DropInput(
          title: _title.text,
          description: _desc.text,
          quantity: _quantity,
          durationMinutes: _minutes,
          proofTypes: offerableProofTypes.where(_proofs.contains).toList(),
        ),
      );
      if (mounted) context.pop(true);
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(l.dropFormTitle)),
      body: AppWidth(
        child: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              Notice(
                l.shopStartDropHint,
                tone: PillTone.accent,
                icon: Icons.bolt,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _title,
                decoration: InputDecoration(
                  labelText: l.dropFormWhat,
                  hintText: l.dropFormWhatHint,
                ),
                maxLength: 80,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l.fieldRequired : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _desc,
                decoration: InputDecoration(labelText: l.dropFormDesc),
                maxLength: 500,
                minLines: 2,
                maxLines: 4,
              ),
              SectionTitle(l.dropFormQuantity),
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: _quantity > 1
                        ? () => setState(() => _quantity--)
                        : null,
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  Expanded(
                    child: Text(
                      '$_quantity',
                      textAlign: TextAlign.center,
                      style: context.text.headlineMedium,
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: _quantity < 50
                        ? () => setState(() => _quantity++)
                        : null,
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
              SectionTitle(l.dropFormDuration),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final m in _durations)
                    ChoiceChip(
                      label: Text(l.dropFormMinutes(m)),
                      selected: _minutes == m,
                      labelStyle: TextStyle(
                        color: _minutes == m ? Colors.white : T.ink,
                        fontWeight: FontWeight.w700,
                      ),
                      onSelected: (_) => setState(() => _minutes = m),
                    ),
                ],
              ),
              SectionTitle(l.formProofTypes),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final p in offerableProofTypes)
                    FilterChip(
                      label: Text(p.label(l)),
                      selected: _proofs.contains(p),
                      labelStyle: TextStyle(
                        color: _proofs.contains(p) ? Colors.white : T.ink,
                        fontWeight: FontWeight.w700,
                      ),
                      onSelected: (on) => setState(
                        () => on ? _proofs.add(p) : _proofs.remove(p),
                      ),
                    ),
                ],
              ),
              if (_proofs.isEmpty) ...[
                const SizedBox(height: 8),
                Notice(l.formProofTypesError, tone: PillTone.red),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _busy ? null : _submit,
                icon: _busy
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    : const Icon(Icons.bolt_rounded),
                label: Text(l.dropFormStart),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
