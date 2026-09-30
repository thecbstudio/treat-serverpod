import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/identity_checks.dart' as checks;

/// Student-card check for students without a .edu e-mail, and the
/// verified badge for businesses: upload a photo, the AI decides, the photo
/// is deleted.
class VerificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// The newest check (poll while it is `pending`).
  Future<IdentityCheck?> latest(Session session) => checks.latestCheck(session);

  Future<ProofUpload> upload(Session session) =>
      checks.startCheckUpload(session);

  Future<IdentityCheck> submit(Session session, String path) =>
      checks.submitCheck(session, path);
}
