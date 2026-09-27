import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/accounts.dart';

/// Top students by approved treats. Name + university only, never email.
class LeaderboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<LeaderboardEntry>> top(Session session) async {
    final me = await findStudent(session, requireAuthUserId(session));
    final students = await StudentProfile.db.find(
      session,
      where: (t) => t.treats > 0,
      orderByList: (t) => [t.treats.desc(), t.joinedAt.asc()],
      limit: 50,
    );
    return [
      for (final (i, s) in students.indexed)
        LeaderboardEntry(
          rank: i + 1,
          name: s.name,
          university: s.university,
          treats: s.treats,
          isMe: s.id == me?.id,
        ),
    ];
  }
}
