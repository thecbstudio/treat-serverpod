import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../l10n/app_localizations.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Student card (students without a .edu e-mail) or business document
/// (verified badge): pick a photo, the AI checks it, the photo is deleted.
class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  IdentityCheck? _check;
  bool _loading = true;
  Object? _error;
  Uint8List? _bytes;
  bool _busy = false;
  Timer? _poll;

  bool get _isShop => appSession.status == SessionStatus.shop;

  /// Demo students can send ready-made sample cards.
  bool _demo = false;

  bool get _done {
    final me = appSession.me;
    return _isShop
        ? me?.shop?.verified ?? false
        : me?.student?.verification == StudentVerification.verified;
  }

  @override
  void initState() {
    super.initState();
    _load();
    client.demo
        .enabled()
        .then((on) {
          final email = appSession.me?.student?.email ?? '';
          if (mounted && on && email.endsWith('@demo.treat')) {
            setState(() => _demo = true);
          }
        })
        .catchError((_) {});
  }

  Future<void> _sendSample(SampleCard kind) async {
    setState(() => _busy = true);
    try {
      final check = await client.verification.submitSample(kind);
      if (!mounted) return;
      setState(() => _check = check);
      _watch();
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final check = await client.verification.latest();
      if (!mounted) return;
      setState(() {
        _check = check;
        _loading = false;
        _error = null;
      });
      _watch();
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
          _loading = false;
        });
      }
    }
  }

  /// While the AI is checking, ask again every few seconds.
  void _watch() {
    _poll?.cancel();
    if (_check?.status != CheckStatus.pending) return;
    _poll = Timer.periodic(const Duration(seconds: 3), (_) async {
      try {
        final check = await client.verification.latest();
        if (!mounted || check?.status == CheckStatus.pending) return;
        _poll?.cancel();
        if (check?.status == CheckStatus.approved) await appSession.refresh();
        if (mounted) setState(() => _check = check);
      } catch (_) {
        // Keep polling; a blip shouldn't end the wait.
      }
    });
  }

  Future<void> _pick(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      setState(() => _bytes = bytes);
    } catch (e) {
      if (mounted) context.toast(errorMessage(e, context.l));
    }
  }

  Future<void> _send() async {
    final bytes = _bytes;
    if (bytes == null) return;
    setState(() => _busy = true);
    try {
      final upload = await client.verification.upload();
      final ok = await FileUploader(
        upload.uploadDescription,
      ).uploadByteData(ByteData.sublistView(bytes));
      if (!ok) throw Exception('upload failed');
      final check = await client.verification.submit(upload.path);
      if (!mounted) return;
      setState(() {
        _check = check;
        _bytes = null;
      });
      _watch();
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
      appBar: AppBar(
        title: Text(_isShop ? l.verifyShopTitle : l.verifyStudentTitle),
        leading: IconButton(
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(_isShop ? '/shop/profile' : '/me'),
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: l.back,
        ),
      ),
      body: SafeArea(
        child: _loading
            ? const LoadingView()
            : _error != null
            ? ErrorView(error: _error!, onRetry: _load)
            : AppWidth(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: _done ? [_verified(context)] : _form(context),
                ),
              ),
      ),
    );
  }

  Widget _verified(BuildContext context) => Notice(
    _isShop ? context.l.verifyShopDone : context.l.verifyStudentDone,
    tone: PillTone.green,
    icon: Icons.verified_rounded,
  );

  List<Widget> _form(BuildContext context) {
    final l = context.l;
    final me = appSession.me;
    final check = _check;
    final pending = check?.status == CheckStatus.pending;
    return [
      Text(
        _isShop ? l.verifyShopIntro : l.verifyStudentIntro,
        style: context.text.bodyLarge,
      ),
      const SizedBox(height: 12),
      TreatCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.verifyMustMatch, style: context.text.labelLarge),
            const SizedBox(height: 6),
            if (_isShop) ...[
              Text(me?.shop?.name ?? '', style: context.text.titleMedium),
              Text(
                '${me?.shop?.address}, ${me?.shop?.district}',
                style: context.text.bodyMedium,
              ),
            ] else ...[
              Text(me?.student?.name ?? '', style: context.text.titleMedium),
              Text(
                me?.student?.university ?? '',
                style: context.text.bodyMedium,
              ),
            ],
            const SizedBox(height: 6),
            Text(
              _isShop ? l.verifyShopMatchHint : l.verifyStudentMatchHint,
              style: context.text.bodySmall?.copyWith(color: T.inkSecondary),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      if (check != null && !pending) ...[
        _result(context, check),
        const SizedBox(height: 12),
      ],
      if (pending)
        TreatCard(
          child: Row(
            children: [
              const SizedBox.square(
                dimension: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(l.verifyChecking, style: context.text.bodyLarge),
              ),
            ],
          ),
        )
      else ...[
        if (_bytes != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(T.radiusMd),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 320),
              child: Image.memory(_bytes!, fit: BoxFit.contain),
            ),
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _busy ? null : () => _pick(ImageSource.camera),
                icon: const Icon(Icons.photo_camera_outlined),
                label: Text(l.verifyTakePhoto),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _busy ? null : () => _pick(ImageSource.gallery),
                icon: const Icon(Icons.photo_library_outlined),
                label: Text(l.verifyChoosePhoto),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: _bytes == null || _busy ? null : _send,
          child: _busy
              ? const SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                )
              : Text(l.verifySend),
        ),
      ],
      if (_demo && !pending && !_isShop) ...[
        const SizedBox(height: 16),
        TreatCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l.verifySampleTitle, style: context.text.titleSmall),
              const SizedBox(height: 4),
              Text(
                l.verifySampleHint,
                style: context.text.bodySmall?.copyWith(color: T.inkSecondary),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: _busy
                        ? null
                        : () => _sendSample(SampleCard.matching),
                    child: Text(l.verifySampleMatching),
                  ),
                  OutlinedButton(
                    onPressed: _busy
                        ? null
                        : () => _sendSample(SampleCard.someoneElse),
                    child: Text(l.verifySampleOther),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      const SizedBox(height: 16),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            size: 16,
            color: T.inkTertiary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l.verifyPrivacy,
              style: context.text.bodySmall?.copyWith(color: T.inkSecondary),
            ),
          ),
        ],
      ),
    ];
  }

  Widget _result(BuildContext context, IdentityCheck check) {
    final l = context.l;
    return switch (check.status) {
      CheckStatus.rejected => Notice(
        verifyReasonText(check.reason, l),
        tone: PillTone.red,
        icon: Icons.error_outline_rounded,
      ),
      CheckStatus.failed => Notice(
        l.verifyFailed,
        tone: PillTone.amber,
        icon: Icons.refresh_rounded,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

String verifyReasonText(String? reason, AppLocalizations l) => switch (reason) {
  'not_a_student_card' => l.verifyNotAStudentCard,
  'not_a_business_document' => l.verifyNotABusinessDocument,
  'name_mismatch' => l.verifyNameMismatch,
  'school_mismatch' => l.verifySchoolMismatch,
  'expired' => l.verifyExpired,
  _ => l.verifyUnreadable,
};
