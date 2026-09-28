import 'package:flutter/material.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/widgets.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late Future<List<LeaderboardEntry>> _future = client.leaderboard.top();

  Future<void> _reload() async {
    final f = client.leaderboard.top();
    setState(() => _future = f);
    await f.catchError((_) => <LeaderboardEntry>[]);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      body: SafeArea(
        child: AppWidth(
          child: RefreshIndicator(
            color: T.accent,
            onRefresh: _reload,
            child: FutureBuilder(
              future: _future,
              builder: (context, snap) {
                final header = Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.leaderboardTitle,
                        style: context.text.headlineMedium,
                      ),
                      Text(
                        l.leaderboardSubtitle,
                        style: context.text.bodyMedium?.copyWith(
                          color: T.inkSecondary,
                        ),
                      ),
                    ],
                  ),
                );
                if (snap.hasError) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      header,
                      ErrorView(error: snap.error!, onRetry: _reload),
                    ],
                  );
                }
                if (!snap.hasData) return const LoadingView();
                final rows = snap.data!;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  children: [
                    header,
                    if (rows.isEmpty)
                      EmptyView(
                        icon: Icons.emoji_events_outlined,
                        title: l.leaderboardEmpty,
                      ),
                    for (final r in rows)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _Row(entry: r),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.entry});
  final LeaderboardEntry entry;

  @override
  Widget build(BuildContext context) {
    final medal = switch (entry.rank) {
      1 => T.gold,
      2 => T.inkTertiary,
      3 => const Color(0xFFB87333),
      _ => null,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: entry.isMe ? T.accentSoft : T.card,
        borderRadius: BorderRadius.circular(T.radiusMd),
        border: Border.all(color: entry.isMe ? T.accent : T.border),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: medal == null
                ? Text(
                    '${entry.rank}',
                    style: context.text.titleMedium?.copyWith(
                      color: T.inkTertiary,
                    ),
                  )
                : Icon(Icons.emoji_events_rounded, color: medal),
          ),
          InitialsAvatar(entry.name, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.isMe
                      ? '${entry.name} (${context.l.leaderboardYou})'
                      : entry.name,
                  style: context.text.titleSmall,
                ),
                Text(
                  entry.university,
                  style: context.text.bodySmall?.copyWith(
                    color: T.inkSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            context.l.leaderboardTreats(entry.treats),
            style: context.text.titleSmall?.copyWith(color: T.accentInk),
          ),
        ],
      ),
    );
  }
}
