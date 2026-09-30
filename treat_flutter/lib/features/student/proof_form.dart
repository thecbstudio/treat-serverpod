import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Pick which post was made, pick the screenshot, upload, submit. Used for the
/// first proof and for the one appeal. The claim screen follows the result
/// live, so there's nothing to do after a successful submit.
extension on List<ProofType> {
  /// Never leave the form without a choice (an old offer might only list a
  /// Google review).
  List<ProofType> ifEmpty(ProofType fallback) => isEmpty ? [fallback] : this;
}

class ProofForm extends StatefulWidget {
  const ProofForm({
    super.key,
    required this.claimId,
    required this.proofTypes,
    required this.submitLabel,
    required this.shopName,
    this.instagramHandle,
  });

  final int claimId;
  final String shopName;
  final String? instagramHandle;
  final List<ProofType> proofTypes;
  final String submitLabel;

  @override
  State<ProofForm> createState() => _ProofFormState();
}

class _ProofFormState extends State<ProofForm> {
  // Older offers may still list a Google review; it's no longer accepted.
  late final List<ProofType> _types = [
    ...widget.proofTypes.where(offerableProofTypes.contains),
  ].ifEmpty(ProofType.igStory);
  late ProofType _type = _types.first;
  XFile? _file;
  Uint8List? _bytes;
  bool _busy = false;
  bool _share = true;
  final _link = TextEditingController();

  /// Feed posts, Reels and TikToks stay online: we ask for their link.
  bool get _needsLink => _type == ProofType.igPost || _type == ProofType.tiktok;

  @override
  void dispose() {
    _link.dispose();
    super.dispose();
  }

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
      await client.claim.submitProof(
        widget.claimId,
        _type,
        upload.path,
        shareOnWall: _share,
        postUrl: _needsLink ? _link.text : null,
      );
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _submitSample(SampleProof kind) async {
    setState(() => _busy = true);
    try {
      await client.claim.submitSampleProof(widget.claimId, kind);
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// What to put in the post: the place's tag and the ad disclosure.
  String get _tags {
    final handle = widget.instagramHandle;
    return handle == null ? '#işbirliği' : '@$handle #işbirliği';
  }

  /// Demo accounts can send a ready-made story instead of a real post; the
  /// samples are IG stories, so only where a story is accepted.
  bool get _offerSamples =>
      (appSession.me?.student?.email.endsWith('@demo.treat') ?? false) &&
      widget.proofTypes.contains(ProofType.igStory);

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_types.length > 1) ...[
          Text(l.proofPickOne, style: context.text.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in _types)
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
        if (_type != ProofType.googleReview) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: ActionChip(
              avatar: const Icon(Icons.copy_rounded, size: 16),
              label: Text(l.proofCopyTags(_tags)),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: _tags));
                if (context.mounted) context.toast(l.proofCopied);
              },
            ),
          ),
        ],
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
        if (_needsLink) ...[
          const SizedBox(height: 10),
          TextField(
            controller: _link,
            keyboardType: TextInputType.url,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l.proofLinkLabel,
              hintText: _type == ProofType.tiktok
                  ? 'https://www.tiktok.com/@you/video/…'
                  : 'https://www.instagram.com/p/…',
              helperText: l.proofLinkHelp,
              helperMaxLines: 3,
              prefixIcon: const Icon(Icons.link_rounded),
            ),
          ),
        ],
        const SizedBox(height: 4),
        CheckboxListTile(
          value: _share,
          onChanged: _busy ? null : (v) => setState(() => _share = v ?? false),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: T.accent,
          title: Text(l.proofShareOnWall(widget.shopName)),
          subtitle: Text(l.proofShareHint),
        ),
        const SizedBox(height: 6),
        FilledButton.icon(
          onPressed:
              _bytes == null ||
                  _busy ||
                  (_needsLink && _link.text.trim().isEmpty)
              ? null
              : _submit,
          icon: _busy
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                )
              : const Icon(Icons.send_rounded),
          label: Text(_busy ? l.proofUploading : widget.submitLabel),
        ),
        if (_offerSamples) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: T.bgHover,
              borderRadius: BorderRadius.circular(T.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l.proofSampleTitle, style: context.text.titleSmall),
                const SizedBox(height: 2),
                Text(
                  l.proofSampleHint,
                  style: context.text.bodySmall?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                for (final (kind, icon, label) in [
                  (
                    SampleProof.tagsPlace,
                    Icons.verified_outlined,
                    l.proofSampleGood(widget.shopName),
                  ),
                  (
                    SampleProof.noDisclosure,
                    Icons.report_gmailerrorred_rounded,
                    l.proofSampleUndisclosed,
                  ),
                  (
                    SampleProof.tagsNobody,
                    Icons.do_not_disturb_alt_rounded,
                    l.proofSampleBad,
                  ),
                ]) ...[
                  OutlinedButton.icon(
                    onPressed: _busy ? null : () => _submitSample(kind),
                    icon: Icon(icon),
                    label: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
