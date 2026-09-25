import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Create or edit an offer. Pops `true` when saved.
class OfferFormScreen extends StatefulWidget {
  const OfferFormScreen({super.key, this.offer});
  final Offer? offer;

  @override
  State<OfferFormScreen> createState() => _OfferFormScreenState();
}

class _OfferFormScreenState extends State<OfferFormScreen> {
  final _form = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.offer?.title);
  late final _desc = TextEditingController(text: widget.offer?.description);
  late final _dailyCap = TextEditingController(
    text: widget.offer?.dailyCap?.toString(),
  );
  late final _totalCap = TextEditingController(
    text: widget.offer?.totalCap?.toString(),
  );
  late OfferFrequency _frequency =
      widget.offer?.frequency ?? OfferFrequency.weekly;
  late int _start = widget.offer?.activeStartMin ?? 9 * 60;
  late int _end = widget.offer?.activeEndMin ?? 18 * 60;
  late final Set<ProofType> _proofs = {
    ...?widget.offer?.proofTypes,
    if (widget.offer == null) ProofType.igStory,
  };
  bool _busy = false;
  bool _triedSubmit = false;

  @override
  void dispose() {
    for (final c in [_title, _desc, _dailyCap, _totalCap]) {
      c.dispose();
    }
    super.dispose();
  }

  int? _cap(TextEditingController c) =>
      c.text.trim().isEmpty ? null : int.tryParse(c.text.trim());

  String? _capValidator(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    final n = int.tryParse(v.trim());
    return (n == null || n < 1) ? context.l.formCapError : null;
  }

  Future<void> _pickTime(bool start) async {
    final current = start ? _start : _end;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null) return;
    final minutes = picked.hour * 60 + picked.minute;
    setState(() => start ? _start = minutes : _end = minutes);
  }

  Future<void> _submit() async {
    setState(() => _triedSubmit = true);
    final valid = _form.currentState!.validate();
    if (!valid || _start >= _end || _proofs.isEmpty) return;
    setState(() => _busy = true);
    final input = OfferInput(
      title: _title.text,
      description: _desc.text,
      frequency: _frequency,
      activeStartMin: _start,
      activeEndMin: _end,
      dailyCap: _cap(_dailyCap),
      totalCap: _cap(_totalCap),
      proofTypes: ProofType.values.where(_proofs.contains).toList(),
    );
    try {
      if (widget.offer == null) {
        await client.shopOffers.create(input);
      } else {
        await client.shopOffers.update(widget.offer!.id!, input);
      }
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
    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l.fieldRequired : null;
    final hoursError = _start >= _end;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offer == null ? l.formNewOffer : l.formEditOffer),
      ),
      body: AppWidth(
        child: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              TextFormField(
                controller: _title,
                decoration: InputDecoration(
                  labelText: l.formWhat,
                  hintText: l.formWhatHint,
                ),
                maxLength: 80,
                validator: required,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _desc,
                decoration: InputDecoration(
                  labelText: l.formDesc,
                  hintText: l.formDescHint,
                ),
                maxLength: 500,
                minLines: 3,
                maxLines: 6,
                validator: required,
              ),
              SectionTitle(l.formFrequency),
              SegmentedButton<OfferFrequency>(
                segments: [
                  for (final f in OfferFrequency.values)
                    ButtonSegment(value: f, label: Text(f.label(l))),
                ],
                selected: {_frequency},
                onSelectionChanged: (s) =>
                    setState(() => _frequency = s.single),
              ),
              SectionTitle(l.formHours),
              Row(
                children: [
                  Expanded(
                    child: _TimeButton(
                      label: l.formFrom,
                      value: hhmm(_start),
                      onTap: () => _pickTime(true),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _TimeButton(
                      label: l.formTo,
                      value: hhmm(_end),
                      onTap: () => _pickTime(false),
                    ),
                  ),
                ],
              ),
              if (hoursError) ...[
                const SizedBox(height: 8),
                Notice(l.formHoursError, tone: PillTone.red),
              ],
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dailyCap,
                      decoration: InputDecoration(
                        labelText: l.formDailyCap,
                        helperText: l.formCapHint,
                      ),
                      keyboardType: TextInputType.number,
                      validator: _capValidator,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _totalCap,
                      decoration: InputDecoration(
                        labelText: l.formTotalCap,
                        helperText: l.formCapHint,
                      ),
                      keyboardType: TextInputType.number,
                      validator: _capValidator,
                    ),
                  ),
                ],
              ),
              SectionTitle(l.formProofTypes),
              Text(
                l.formProofTypesHint,
                style: context.text.bodySmall?.copyWith(color: T.inkSecondary),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final p in ProofType.values)
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
              if (_triedSubmit && _proofs.isEmpty) ...[
                const SizedBox(height: 8),
                Notice(l.formProofTypesError, tone: PillTone.red),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _busy ? null : _submit,
                child: _busy
                    ? const SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    : Text(widget.offer == null ? l.formPublish : l.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  const _TimeButton({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: onTap,
    style: OutlinedButton.styleFrom(
      backgroundColor: T.card,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: context.text.bodyMedium?.copyWith(color: T.inkSecondary),
        ),
        const Spacer(),
        Text(value, style: context.text.titleMedium),
      ],
    ),
  );
}
