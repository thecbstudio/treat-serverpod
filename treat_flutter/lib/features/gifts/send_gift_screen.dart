import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import 'gift_ui.dart';

/// Pick a place, an amount and a friend, then pay on iyzico's page. The
/// friend is either typed by e-mail or preselected from their profile
/// (`/gifts/new?to=<studentId>&name=<name>`).
class SendGiftScreen extends StatefulWidget {
  const SendGiftScreen({super.key, this.toStudentId, this.toName});
  final int? toStudentId;
  final String? toName;

  @override
  State<SendGiftScreen> createState() => _SendGiftScreenState();
}

class _SendGiftScreenState extends State<SendGiftScreen> {
  static const _presets = [20, 50, 100, 200];

  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _message = TextEditingController();
  final _custom = TextEditingController();
  late Future<({List<Shop> places, String mode})> _future = _load();
  int? _shopId;
  int _amount = 50;
  bool _busy = false;

  Future<({List<Shop> places, String mode})> _load() async {
    final results = await Future.wait([
      client.gift.places(),
      client.gift.mode(),
    ]);
    return (places: results[0] as List<Shop>, mode: results[1] as String);
  }

  @override
  void dispose() {
    _email.dispose();
    _message.dispose();
    _custom.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
    if (!_form.currentState!.validate() || _shopId == null) return;
    setState(() => _busy = true);
    try {
      final checkout = await client.gift.send(
        GiftInput(
          shopId: _shopId!,
          amountTl: _amount,
          recipientEmail: widget.toStudentId == null ? _email.text : null,
          recipientStudentId: widget.toStudentId,
          message: _message.text,
        ),
      );
      // Same tab: iyzico sends the browser back to this gift afterwards.
      await launchUrl(
        Uri.parse(checkout.paymentPageUrl),
        webOnlyWindowName: '_self',
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
    return Scaffold(
      appBar: AppBar(
        title: Text(l.giftSendTitle),
        leading: IconButton(
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/gifts'),
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: l.back,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            if (snap.hasError) {
              return ErrorView(
                error: snap.error!,
                onRetry: () => setState(() => _future = _load()),
              );
            }
            if (!snap.hasData) return const LoadingView();
            final (:places, :mode) = snap.data!;
            if (mode == 'off') {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Notice(l.giftsOff, icon: Icons.info_outline_rounded),
              );
            }
            if (places.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Notice(l.giftNoPlaces, icon: Icons.info_outline_rounded),
              );
            }
            final place = places.where((p) => p.id == _shopId).firstOrNull;
            final net = _amount * 0.85;
            final commission = _amount * 0.15;
            return AppWidth(
              child: Form(
                key: _form,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (widget.toStudentId != null)
                      Row(
                        children: [
                          InitialsAvatar(widget.toName ?? '?'),
                          const SizedBox(width: 10),
                          Text(
                            l.giftToName(widget.toName ?? ''),
                            style: context.text.titleMedium,
                          ),
                        ],
                      )
                    else
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: l.giftRecipient,
                          helperText: l.giftRecipientHelp,
                        ),
                        validator: (v) => (v == null || !v.contains('@'))
                            ? l.fieldRequired
                            : null,
                      ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      initialValue: _shopId,
                      isExpanded: true,
                      decoration: InputDecoration(labelText: l.giftPlace),
                      items: [
                        for (final p in places)
                          DropdownMenuItem(
                            value: p.id,
                            child: Text(
                              '${p.name} · ${p.district}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: (v) => setState(() => _shopId = v),
                      validator: (v) => v == null ? l.fieldRequired : null,
                    ),
                    const SizedBox(height: 16),
                    Text(l.giftAmountLabel, style: context.text.labelLarge),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final p in _presets)
                          ChoiceChip(
                            label: Text('$p TL'),
                            selected: _amount == p && _custom.text.isEmpty,
                            onSelected: (_) => setState(() {
                              _amount = p;
                              _custom.clear();
                            }),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _custom,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 4,
                      decoration: InputDecoration(
                        labelText: l.giftAmountLabel,
                        helperText: l.giftAmountHelp,
                        counterText: '',
                      ),
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        setState(() => _amount = n ?? 0);
                      },
                      validator: (_) => _amount < 20 || _amount > 1000
                          ? l.err_invalid_amount
                          : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _message,
                      maxLength: 140,
                      decoration: InputDecoration(labelText: l.giftMessage),
                    ),
                    if (place != null && _amount >= 20 && _amount <= 1000)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Notice(
                          l.giftSplit(
                            place.name,
                            formatTl(net),
                            formatTl(commission),
                          ),
                          tone: PillTone.neutral,
                          icon: Icons.pie_chart_outline_rounded,
                        ),
                      ),
                    FilledButton.icon(
                      onPressed: _busy ? null : _pay,
                      icon: _busy
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.lock_outline_rounded),
                      label: Text(l.giftPay(_amount)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l.giftSecure,
                      style: context.text.bodySmall?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                    if (mode == 'sandbox') ...[
                      const SizedBox(height: 10),
                      Notice(
                        l.giftSandboxHint,
                        tone: PillTone.amber,
                        icon: Icons.science_outlined,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
