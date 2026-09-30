import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treat_client/treat_client.dart';

import '../../app/session.dart';
import '../../app/theme.dart';
import '../../ui/labels.dart';
import '../../ui/widgets.dart';

const _maxStrikes = 3;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: appSession,
    builder: (context, _) {
      final me = appSession.me;
      final student = me?.student;
      if (me == null || student == null) return const LoadingView();
      return Scaffold(
        body: SafeArea(
          child: AppWidth(
            child: RefreshIndicator(
              color: T.accent,
              onRefresh: appSession.refresh,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _Header(me: me, student: student),
                      ),
                      IconButton(
                        onPressed: () => context.push('/settings'),
                        icon: const Icon(Icons.settings_outlined),
                        tooltip: context.l.settingsTitle,
                      ),
                    ],
                  ),
                  if (student.verification != StudentVerification.verified) ...[
                    const SizedBox(height: 14),
                    Notice(
                      context.l.lockNotVerified,
                      tone: PillTone.amber,
                      icon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      onPressed: () => context.push('/verify'),
                      icon: const Icon(Icons.badge_outlined),
                      label: Text(context.l.verifyCta),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _Stat(context.l.profileTreats, '${student.treats}'),
                      const SizedBox(width: 10),
                      _Stat(context.l.profileStreak, '${me.streakWeeks}'),
                    ],
                  ),
                  SectionTitle(context.l.profileBadges),
                  if (me.badges.isEmpty)
                    Text(
                      context.l.profileNoBadges,
                      style: context.text.bodyMedium?.copyWith(
                        color: T.inkSecondary,
                      ),
                    )
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final b in me.badges)
                          Pill(
                            b.label(context.l),
                            tone: PillTone.amber,
                            icon: Icons.emoji_events_outlined,
                          ),
                      ],
                    ),
                  SectionTitle(context.l.profileStrikes),
                  Notice(
                    student.strikes == 0
                        ? context.l.profileNoStrikes
                        : context.l.profileStrikesNote(
                            student.strikes,
                            _maxStrikes,
                          ),
                    tone: student.strikes == 0 ? PillTone.green : PillTone.red,
                    icon: student.strikes == 0
                        ? Icons.check_circle_outline_rounded
                        : Icons.warning_amber_rounded,
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/settings'),
                    icon: const Icon(Icons.settings_outlined),
                    label: Text(context.l.settingsTitle),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: appSession.signOut,
                    icon: const Icon(Icons.logout_rounded),
                    label: Text(context.l.logout),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.me, required this.student});
  final Me me;
  final StudentProfile student;

  @override
  Widget build(BuildContext context) {
    final verified = student.verification == StudentVerification.verified;
    return Row(
      children: [
        InitialsAvatar(student.name, size: 64),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(student.name, style: context.text.titleLarge),
              Text(
                student.university,
                style: context.text.bodyMedium?.copyWith(
                  color: T.inkSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Pill(
                verified ? context.l.profileVerified : context.l.profilePending,
                tone: verified ? PillTone.green : PillTone.amber,
                icon: verified ? Icons.verified_rounded : Icons.hourglass_top,
              ),
              const SizedBox(height: 4),
              Text(
                context.l.profileMemberSince(istanbulDate(student.joinedAt)),
                style: context.text.bodySmall?.copyWith(color: T.inkTertiary),
              ),
            ],
          ),
        ),
      ],
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
