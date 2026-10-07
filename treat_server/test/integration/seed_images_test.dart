import 'dart:io';

import 'package:test/test.dart';
import 'package:treat_server/src/seed/demo_history.dart';
import 'package:treat_server/src/services/demo.dart' show seedAssetPath;
import 'package:treat_server/src/services/proofs.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given storage without the seed screenshots', (
    sessionBuilder,
    endpoints,
  ) {
    test('when the boot step runs then every screenshot is stored, and a '
        'second run changes nothing', () async {
      final session = sessionBuilder.build();
      final files = Directory(
        seedAssetPath('proofs'),
      ).listSync().whereType<File>().map((f) => f.uri.pathSegments.last);
      expect(files, isNotEmpty);
      for (final name in files) {
        expect(
          await session.storage.fileExists(
            storageId: proofStorage,
            path: 'proofs/seed/$name',
          ),
          isFalse,
        );
      }
      await ensureSeedProofImages(session);
      await ensureSeedProofImages(session);
      for (final name in files) {
        expect(
          await session.storage.fileExists(
            storageId: proofStorage,
            path: 'proofs/seed/$name',
          ),
          isTrue,
          reason: name,
        );
      }
    });
  });
}
