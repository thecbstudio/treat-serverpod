import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/theme.dart';
import '../../client.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';
import 'wall.dart';

/// A student's public profile: treats, streak, badges and shared posts.
class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key, required this.studentId});
  final int studentId;

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late Future<PublicStudent> _future = client.social.student(widget.studentId);

  void _reload() =>
      setState(() => _future = client.social.student(widget.studentId));

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.studentProfileTitle),
        leading: BackButton(
          onPressed: () => context.canPop() ? context.pop() : context.go('/'),
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snap) {
          if (snap.hasError) {
            return ErrorView(error: snap.error!, onRetry: _reload);
          }
          if (!snap.hasData) return const LoadingView();
          final s = snap.data!;
          return AppWidth(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    InitialsAvatar(s.name, size: 64),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.name, style: context.text.titleLarge),
                          Text(
                            s.university,
                            style: context.text.bodyMedium?.copyWith(
                              color: T.inkSecondary,
                            ),
                          ),
                          Text(
                            l.profileMemberSince(istanbulDate(s.joinedAt)),
                            style: context.text.bodySmall?.copyWith(
                              color: T.inkTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _Stat(l.profileTreats, '${s.treats}'),
                    const SizedBox(width: 10),
                    _Stat(l.profileStreak, '${s.streakWeeks}'),
                  ],
                ),
                if (s.badges.isNotEmpty) ...[
                  SectionTitle(l.profileBadges),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final b in s.badges)
                        Pill(
                          b.label(l),
                          tone: PillTone.amber,
                          icon: Icons.emoji_events_outlined,
                        ),
                    ],
                  ),
                ],
                SectionTitle(l.wallTitle),
                WallGrid(posts: s.wall, showShop: true),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Expanded(
    child: TreatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: context.text.headlineMedium?.copyWith(color: T.accent),
          ),
          Text(
            label,
            style: context.text.labelLarge?.copyWith(color: T.inkSecondary),
          ),
        ],
      ),
    ),
  );
}
