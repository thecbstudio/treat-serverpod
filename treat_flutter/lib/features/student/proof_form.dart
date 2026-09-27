import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Pick which post was made, pick the screenshot, upload, submit. Used for the
/// first proof and for the one appeal. The claim screen follows the result
/// live, so there's nothing to do after a successful submit.
class ProofForm extends StatefulWidget {
  const ProofForm({
    super.key,
    required this.claimId,
    required this.proofTypes,
    required this.submitLabel,
  });

  final int claimId;
  final List<ProofType> proofTypes;
  final String submitLabel;

  @override
  State<ProofForm> createState() => _ProofFormState();
}

class _ProofFormState extends State<ProofForm> {
  late ProofType _type = widget.proofTypes.first;
  XFile? _file;
  Uint8List? _bytes;
  bool _busy = false;

  Future<void> _pick() async {
    try {
      // Downsized in the browser before upload.
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1280,
        maxHeight: 1280,
        imageQuality: 80,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      setState(() {
        _file = file;
        _bytes = bytes;
      });
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    }
  }

  Future<void> _submit() async {
    final bytes = _bytes;
    if (bytes == null) return;
    setState(() => _busy = true);
    try {
      final upload = await client.claim.proofUpload(widget.claimId);
      final ok = await FileUploader(
        upload.uploadDescription,
      ).uploadByteData(ByteData.sublistView(bytes));
      if (!ok) throw Exception('upload failed');
      await client.claim.submitProof(widget.claimId, _type, upload.path);
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.proofTypes.length > 1) ...[
          Text(l.proofPickOne, style: context.text.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in widget.proofTypes)
                ChoiceChip(
                  label: Text(p.label(l)),
                  selected: _type == p,
                  labelStyle: TextStyle(
                    color: _type == p ? Colors.white : T.ink,
                    fontWeight: FontWeight.w700,
                  ),
                  onSelected: _busy ? null : (_) => setState(() => _type = p),
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        Notice(_type.todo(l), tone: PillTone.accent, icon: Icons.campaign),
        const SizedBox(height: 12),
        if (_bytes != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(T.radiusMd),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 320),
              child: Image.memory(_bytes!, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 10),
        ],
        OutlinedButton.icon(
          onPressed: _busy ? null : _pick,
          icon: const Icon(Icons.image_outlined),
          label: Text(_file == null ? l.proofChoose : l.proofChange),
        ),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: _bytes == null || _busy ? null : _submit,
          icon: _busy
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                )
              : const Icon(Icons.send_rounded),
          label: Text(_busy ? l.proofUploading : widget.submitLabel),
        ),
      ],
    );
  }
}
