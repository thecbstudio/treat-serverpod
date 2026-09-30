import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treat_client/treat_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

/// The place's reputation kit: its public page on treat, and a printable
/// counter card whose front asks every customer for a Google review (via
/// the place's own review link) and whose back advertises its treat.
class ReputationTools extends StatefulWidget {
  const ReputationTools({super.key, required this.shop});
  final Shop shop;

  @override
  State<ReputationTools> createState() => _ReputationToolsState();
}

class _ReputationToolsState extends State<ReputationTools> {
  late final _google = TextEditingController(
    text: widget.shop.googleReviewUrl,
  );
  bool _busy = false;

  @override
  void dispose() {
    _google.dispose();
    super.dispose();
  }

  Uri _web(String path) => Uri.base.resolve(path);

  Future<void> _open(String path) =>
      launchUrl(_web(path), webOnlyWindowName: '_blank');

  Future<void> _saveGoogle() async {
    setState(() => _busy = true);
    try {
      final updated = await client.profile.setGoogleReviewUrl(_google.text);
      final me = appSession.me;
      if (me != null) appSession.apply(me.copyWith(shop: updated));
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
    final id = widget.shop.id!;
    final pageUrl = _web('/p/$id').toString();
    return TreatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium_outlined, color: T.accent),
              const SizedBox(width: 8),
              Text(l.repTitle, style: context.text.titleMedium),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            l.repIntro,
            style: context.text.bodySmall?.copyWith(color: T.inkSecondary),
          ),
          const SizedBox(height: 14),
          Text(l.repPageTitle, style: context.text.titleSmall),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _open('/p/$id'),
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: Text(l.repOpenPage),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.outlined(
                tooltip: l.repCopyLink,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: pageUrl));
                  if (context.mounted) context.toast(l.repLinkCopied);
                },
                icon: const Icon(Icons.link_rounded),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(l.repCardTitle, style: context.text.titleSmall),
          const SizedBox(height: 2),
          Text(
            l.repCardHint,
            style: context.text.bodySmall?.copyWith(color: T.inkSecondary),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _google,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              hintText: 'https://g.page/r/…/review',
              labelText: l.repGoogleLabel,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _busy ? null : _saveGoogle,
                  child: Text(l.save),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _open('/card/$id'),
                  icon: const Icon(Icons.print_outlined, size: 18),
                  label: Text(l.repPrintCard),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
