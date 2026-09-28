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

/// Demo students: the seeded jury student and every one-tap guest.
bool isDemoStudent(StudentProfile s) => s.email.endsWith('@demo.treat');

/// A story screenshot that tags [shop] (for seeded places), or one that tags
/// nobody. Real Claude verifies either one like any upload.
Future<List<int>?> sampleProofBytes(Shop shop, {required bool good}) async {
  if (!good) return File('seed_assets/samples/no_mention.jpg').readAsBytes();
  final key = shop.seedKey;
  if (key == null) return null;
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
