import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../generated/protocol.dart';
import 'accounts.dart';

/// Kinds of post that stay online (unlike 24-hour stories). For these the
/// student also gives the post's link, the place can open it, and the place
/// can report it removed for longer.
const permanentProofTypes = {ProofType.igPost, ProofType.tiktok};

/// How long after approval a TikTok is re-checked, and how long a place can
/// report a permanent post as removed.
const stillUpAfter = Duration(days: 7);

const _instagramHosts = {'instagram.com', 'www.instagram.com'};
const _tiktokHosts = {
  'tiktok.com',
  'www.tiktok.com',
  'm.tiktok.com',
  'vm.tiktok.com',
  'vt.tiktok.com',
};

/// Checks the post link for [type]: required for permanent kinds, must be an
/// https Instagram (post/reel) or TikTok link. Returns the cleaned link, or
/// null for stories.
String? validPostUrl(ProofType type, String? input) {
  if (!permanentProofTypes.contains(type)) return null;
  final t = input?.trim();
  if (t == null || t.isEmpty) {
    throw treatError(
      'post_link_required',
      'Paste the link to your post so the place can see it.',
    );
  }
  final uri = Uri.tryParse(t);
  final host = uri?.host.toLowerCase();
  final ok =
      uri != null &&
      uri.scheme == 'https' &&
      t.length <= 300 &&
      switch (type) {
        ProofType.igPost =>
          _instagramHosts.contains(host) &&
              RegExp(r'^/(p|reel|reels)/[\w-]+').hasMatch(uri.path),
        ProofType.tiktok => _tiktokHosts.contains(host),
        _ => false,
      };
  if (!ok) {
    throw treatError(
      'invalid_post_link',
      'Use the share link of your Instagram post/Reel or TikTok.',
    );
  }
  // Drop tracking parameters (?igsh=…, ?_r=…) from share links.
  return Uri(scheme: 'https', host: uri.host, path: uri.path).toString();
}

/// Is the post still online? true / false, or null when we can't tell (then
/// the check is simply tried again later). Swappable for tests.
typedef PostStillUp = Future<bool?> Function(String url);

PostStillUp? postStillUpOverride;

/// TikTok's public oEmbed endpoint answers 200 for a live video and 400/404
/// once it's deleted or private. Instagram has no public equivalent (Meta
/// requires an app review), so Instagram posts rely on the place's report.
Future<bool?> tiktokStillUp(String url) async {
  try {
    final res = await http
        .get(
          Uri.https('www.tiktok.com', '/oembed', {'url': url}),
        )
        .timeout(const Duration(seconds: 15));
    if (res.statusCode == 200) return true;
    if (res.statusCode == 400 || res.statusCode == 404) return false;
    return null;
  } catch (_) {
    return null;
  }
}

/// TikToks approved at least [stillUpAfter] ago and not checked yet.
Future<List<Claim>> tiktoksDueForCheck(Session session) => Claim.db.find(
  session,
  where: (t) =>
      t.status.equals(ClaimStatus.approved) &
      t.proofType.equals(ProofType.tiktok) &
      t.postUrl.notEquals(null) &
      t.stillUpCheckedAt.equals(null) &
      (t.decidedAt < clock().subtract(stillUpAfter)),
  limit: 50,
);
