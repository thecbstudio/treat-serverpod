import 'package:flutter/material.dart';
import 'package:treat_client/treat_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// Opens a server-rendered page (/privacy, /terms) in a new tab.
Future<void> openWebPage(String path) =>
    launchUrl(Uri.base.resolve(path), webOnlyWindowName: '_blank');

/// Privacy notice + terms of use (settings of both roles).
class LegalLinks extends StatelessWidget {
  const LegalLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return TreatCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l.settingsPrivacy),
            trailing: const Icon(Icons.open_in_new_rounded, size: 18),
            onTap: () => openWebPage('/privacy'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l.settingsTerms),
            trailing: const Icon(Icons.open_in_new_rounded, size: 18),
            onTap: () => openWebPage('/terms'),
          ),
        ],
      ),
    );
  }
}

/// Red "Delete account" button → confirm dialog (checkbox, then "Delete
/// forever") → deletes on the server and signs out.
class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key, required this.isShop});
  final bool isShop;

  Future<void> _start(BuildContext context) async {
    final deleted = await showDialog<bool>(
      context: context,
      builder: (_) => _DeleteDialog(isShop: isShop),
    );
    if (deleted != true || !context.mounted) return;
    context.toast(context.l.deleteAccountDone);
    await appSession.signOut();
  }

  @override
  Widget build(BuildContext context) => TextButton.icon(
    onPressed: () => _start(context),
    style: TextButton.styleFrom(foregroundColor: T.red),
    icon: const Icon(Icons.delete_forever_outlined),
    label: Text(context.l.deleteAccount),
  );
}

class _DeleteDialog extends StatefulWidget {
  const _DeleteDialog({required this.isShop});
  final bool isShop;

  @override
  State<_DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<_DeleteDialog> {
  bool _understood = false;
  bool _busy = false;
  String? _error;

  Future<void> _delete() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await client.profile.deleteAccount();
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = errorMessage(e, context.l);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return AlertDialog(
      title: Text(l.deleteAccountTitle),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.isShop ? l.deleteAccountShop : l.deleteAccountStudent),
            const SizedBox(height: 8),
            CheckboxListTile(
              value: _understood,
              onChanged: _busy
                  ? null
                  : (v) => setState(() => _understood = v ?? false),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(l.deleteAccountConfirm),
            ),
            if (_error != null)
              Notice(
                _error!,
                tone: PillTone.red,
                icon: Icons.error_outline_rounded,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(false),
          child: Text(l.cancel),
        ),
        FilledButton(
          onPressed: _understood && !_busy ? _delete : null,
          style: FilledButton.styleFrom(backgroundColor: T.red),
          child: _busy
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: T.inkInverse,
                  ),
                )
              : Text(l.deleteAccountGo),
        ),
      ],
    );
  }
}

/// Lets anyone flag a review, wall post (target = claim id) or place.
Future<void> showReportSheet(
  BuildContext context,
  ReportKind kind,
  int targetId,
) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  constraints: const BoxConstraints(maxWidth: 520),
  builder: (_) => _ReportSheet(kind: kind, targetId: targetId),
);

class _ReportSheet extends StatefulWidget {
  const _ReportSheet({required this.kind, required this.targetId});
  final ReportKind kind;
  final int targetId;

  @override
  State<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<_ReportSheet> {
  ReportReason? _reason;
  bool _busy = false;

  Future<void> _send() async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    final l = context.l;
    try {
      await client.social.report(widget.kind, widget.targetId, _reason!);
      if (!mounted) return;
      Navigator.of(context).pop();
      messenger.showSnackBar(SnackBar(content: Text(l.reportThanks)));
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      messenger.showSnackBar(SnackBar(content: Text(errorMessage(e, l))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final reasons = {
      ReportReason.spam: l.reportSpam,
      ReportReason.offensive: l.reportOffensive,
      ReportReason.fake: l.reportFake,
      ReportReason.privacy: l.reportPrivacy,
      ReportReason.other: l.reportOther,
    };
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              switch (widget.kind) {
                ReportKind.review => l.reportTitleReview,
                ReportKind.wallPost => l.reportTitlePost,
                ReportKind.shop => l.reportTitleShop,
              },
              style: context.text.titleLarge,
            ),
            const SizedBox(height: 8),
            RadioGroup<ReportReason>(
              groupValue: _reason,
              onChanged: (v) => setState(() => _reason = v),
              child: Column(
                children: [
                  for (final e in reasons.entries)
                    RadioListTile<ReportReason>(
                      value: e.key,
                      title: Text(e.value),
                      contentPadding: EdgeInsets.zero,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _reason == null || _busy ? null : _send,
              child: Text(l.reportSend),
            ),
          ],
        ),
      ),
    );
  }
}

/// Whether the signed-in user may report content by [studentId] at
/// [shopId] (the server says no to reporting your own page anyway).
bool canReport({int? studentId, int? shopId}) {
  final me = appSession.me;
  if (me == null) return false;
  if (studentId != null && studentId == me.student?.id) return false;
  if (shopId != null && shopId == me.shop?.id) return false;
  return true;
}
