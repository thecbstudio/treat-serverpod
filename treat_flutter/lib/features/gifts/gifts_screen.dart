import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/widgets.dart';
import 'gift_ui.dart';

/// The Gifts tab: gifts you received (collect them with a QR) and the ones
/// you sent.
class GiftsScreen extends StatefulWidget {
  const GiftsScreen({super.key});

  @override
  State<GiftsScreen> createState() => _GiftsScreenState();
}

class _GiftsScreenState extends State<GiftsScreen> {
  late Future<({List<GiftView> received, List<GiftView> sent, String mode})>
  _future = _load();
  bool _showSent = false;

  Future<({List<GiftView> received, List<GiftView> sent, String mode})>
  _load() async {
    final results = await Future.wait([
      client.gift.received(),
      client.gift.sent(),
      client.gift.mode(),
    ]);
    return (
      received: results[0] as List<GiftView>,
      sent: results[1] as List<GiftView>,
      mode: results[2] as String,
    );
  }

  Future<void> _reload() async {
    final next = _load();
    setState(() => _future = next);
    await next.catchError(
      (_) => (received: <GiftView>[], sent: <GiftView>[], mode: 'off'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      body: SafeArea(
        child: AppWidth(
          child: FutureBuilder(
            future: _future,
            builder: (context, snap) {
              if (snap.hasError) {
                return ErrorView(error: snap.error!, onRetry: _reload);
              }
              if (!snap.hasData) return const LoadingView();
              final data = snap.data!;
              final list = _showSent ? data.sent : data.received;
              return RefreshIndicator(
                color: T.accent,
                onRefresh: _reload,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(l.giftsTitle, style: context.text.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      l.giftsIntro,
                      style: context.text.bodyMedium?.copyWith(
                        color: T.inkSecondary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (data.mode == 'off')
                      Notice(l.giftsOff, icon: Icons.info_outline_rounded)
                    else
                      FilledButton.icon(
                        onPressed: () async {
                          await context.push('/gifts/new');
                          if (mounted) _reload();
                        },
                        icon: const Icon(Icons.card_giftcard_rounded),
                        label: Text(l.giftsSend),
                      ),
                    const SizedBox(height: 16),
                    SegmentedButton<bool>(
                      segments: [
                        ButtonSegment(
                          value: false,
                          label: Text(
                            '${l.giftsReceived} (${data.received.length})',
                          ),
                        ),
                        ButtonSegment(
                          value: true,
                          label: Text('${l.giftsSent} (${data.sent.length})'),
                        ),
                      ],
                      selected: {_showSent},
                      onSelectionChanged: (s) =>
                          setState(() => _showSent = s.first),
                    ),
                    const SizedBox(height: 12),
                    if (list.isEmpty)
                      EmptyView(
                        icon: Icons.card_giftcard_rounded,
                        title: _showSent
                            ? l.giftsEmptySent
                            : l.giftsEmptyReceived,
                      )
                    else
                      for (final v in list)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GiftTile(
                            view: v,
                            onTap: () async {
                              await context.push('/gift/${v.gift.id}');
                              if (mounted) _reload();
                            },
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
