import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'accounts.dart';

/// Demo mode = `demoAccountPassword` is set. It turns on one-tap demo sign-in
/// and sample proof screenshots for demo students. Tests set [demoOverride].
bool? demoOverride;

bool demoModeOn(Session session) =>
    demoOverride ??
    session.serverpod.getPassword('demoAccountPassword') != null;

void requireDemoMode(Session session) {
  if (!demoModeOn(session)) {
    throw treatError('demo_off', 'Demo sign-in is turned off.');
  }
}

/// In demo mode the seeded places are shared by every judge: their profile
/// and seeded offers are read-only, so one visitor can't rename or pause
/// what the next one is about to try. Judges' own offers stay editable.
void requireNotDemoLocked(Session session, {Shop? shop, Offer? offer}) {
  if (!demoModeOn(session)) return;
  if (shop?.seedKey != null || offer?.seedKey != null) {
    throw treatError(
      'demo_locked',
      'This demo place is shared by everyone trying the app, so its seeded '
          'offers and profile are read-only. Create your own offer to try '
          'editing.',
    );
  }
}

/// One-tap guest students (not the seeded ones). Kept off public lists
/// (leaderboard, top students, walls) so a busy judging day doesn't fill
/// them with "Guest 1234".
bool isGuest(StudentProfile s) => s.university == guestUniversity;

const guestUniversity = 'Demo University';

/// The unverified demo guest carries this name, like the sample card photos.
const unverifiedGuestName = 'Ali Yılmaz';

/// Sample student card photos (see [SampleCard]) for demo students.
Future<List<int>> sampleCardBytes(SampleCard kind) => File(
  'seed_assets/samples/cards/'
  '${kind == SampleCard.matching ? 'matching' : 'someone_else'}.jpg',
).readAsBytes();

/// File-name marker for demo sample proofs (see [isSampleProof]).
const sampleProofMarker = '/sample-';

/// Sample proofs are ready-made screenshots, not the student's own post, so
/// they are verified like any proof but never shown on a public wall.
bool isSampleProof(Claim c) =>
    c.proofPath?.contains(sampleProofMarker) ?? false;

/// Demo students: the seeded jury student and every one-tap guest.
bool isDemoStudent(StudentProfile s) => s.email.endsWith('@demo.treat');

/// The shared jury student and the seeded history students: read-only in
/// demo mode, like the seeded places.
bool isSeededDemoStudent(StudentProfile s) =>
    s.email.endsWith('demo.treat') && !isGuest(s);

/// Blocks profile edits and deletion of [isSeededDemoStudent] in demo mode.
void requireNotDemoStudent(Session session, StudentProfile s) {
  if (demoModeOn(session) && isSeededDemoStudent(s)) {
    throw treatError(
      'demo_locked',
      'This demo student is shared by everyone trying the app, so its '
          'profile is read-only. Try it with a one-tap guest instead.',
    );
  }
}

/// A story screenshot for [kind]: tags [shop] with an ad disclosure, tags it
/// without one, or tags nobody. The first two exist for seeded places only.
/// Real Claude verifies it like any upload.
Future<List<int>?> sampleProofBytes(Shop shop, SampleProof kind) async {
  if (kind == SampleProof.tagsNobody) {
    return File('seed_assets/samples/no_mention.jpg').readAsBytes();
  }
  final key = shop.seedKey;
  if (key == null) return null;
  if (kind == SampleProof.noDisclosure) {
    final f = File('seed_assets/samples/undisclosed/$key.jpg');
    return f.existsSync() ? f.readAsBytes() : null;
  }
  final dir = Directory('seed_assets/proofs');
  if (!dir.existsSync()) return null;
  final files =
      dir
          .listSync()
          .whereType<File>()
          .where((f) => f.uri.pathSegments.last.startsWith('${key}_'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  return files.isEmpty ? null : files.first.readAsBytes();
}
