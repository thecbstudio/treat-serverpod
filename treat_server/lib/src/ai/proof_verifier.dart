import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../generated/protocol.dart';

/// Why a proof was rejected. Stable keys, mapped to UI copy on the client.
enum RejectReason { noMention, noDisclosure, notAPost, unreadable }

extension RejectReasonKey on RejectReason {
  String get key => switch (this) {
    RejectReason.noMention => 'no_mention',
    RejectReason.noDisclosure => 'no_disclosure',
    RejectReason.notAPost => 'not_a_post',
    RejectReason.unreadable => 'unreadable',
  };
}

class ProofVerdict {
  const ProofVerdict.approved() : approved = true, reason = null;
  const ProofVerdict.rejected(RejectReason this.reason) : approved = false;

  final bool approved;
  final RejectReason? reason;
}

/// What the verifier needs to judge a screenshot.
class ProofContext {
  const ProofContext({
    required this.image,
    required this.mediaType,
    required this.proofType,
    required this.shopName,
    required this.instagramHandle,
    required this.offerTitle,
  });

  final Uint8List image;
  final String mediaType;
  final ProofType proofType;
  final String shopName;
  final String? instagramHandle;
  final String offerTitle;
}

/// Thrown for transient failures (network, 5xx, malformed answer): the
/// VerifyProof future call retries these and never gives a strike for them.
class VerifierUnavailable implements Exception {
  VerifierUnavailable(this.message);
  final String message;

  @override
  String toString() => 'VerifierUnavailable: $message';
}

abstract interface class ProofVerifier {
  Future<ProofVerdict> verify(ProofContext context);
}

/// Claude via the Anthropic Messages API. The answer is forced into a tool
/// call, so we never parse free text.
class AnthropicProofVerifier implements ProofVerifier {
  AnthropicProofVerifier({
    required this.apiKey,
    this.model = defaultModel,
    http.Client? client,
  }) : _http = client ?? http.Client();

  static const defaultModel = 'claude-sonnet-5';
  static const _tool = 'report_verdict';

  final String apiKey;
  final String model;
  final http.Client _http;

  @override
  Future<ProofVerdict> verify(ProofContext c) async =>
      parseResponse(await postToClaude(_http, apiKey, _request(c)));

  Map<String, Object?> _request(ProofContext c) => {
    'model': model,
    'max_tokens': 400,
    'system':
        'You verify screenshots that students upload to prove they promoted '
        'a local business on social media in exchange for a free product. '
        'Be strict but fair: approve only when the screenshot clearly shows '
        'the requested kind of post, names or tags the business and, for '
        'social posts, discloses that the product was a gift or an ad. If '
        'unsure, reject.',
    'tools': [
      {
        'name': _tool,
        'description': 'Report the verdict for the screenshot.',
        'input_schema': {
          'type': 'object',
          'properties': {
            'approved': {'type': 'boolean'},
            'reason': {
              'type': ['string', 'null'],
              'enum': [
                'no_mention',
                'no_disclosure',
                'not_a_post',
                'unreadable',
                null,
              ],
              'description': 'Required when approved is false, else null.',
            },
          },
          'required': ['approved', 'reason'],
        },
      },
    ],
    'tool_choice': {'type': 'tool', 'name': _tool},
    'messages': [
      {
        'role': 'user',
        'content': [
          {
            'type': 'image',
            'source': {
              'type': 'base64',
              'media_type': c.mediaType,
              'data': base64Encode(c.image),
            },
          },
          {'type': 'text', 'text': buildPrompt(c)},
        ],
      },
    ],
  };
}

/// POSTs a Messages API request and returns the response body. Network
/// errors and non-200 answers become [VerifierUnavailable] (retried).
Future<String> postToClaude(
  http.Client client,
  String apiKey,
  Map<String, Object?> request,
) async {
  final http.Response response;
  try {
    response = await client
        .post(
          Uri.parse('https://api.anthropic.com/v1/messages'),
          headers: {
            'x-api-key': apiKey,
            'anthropic-version': '2023-06-01',
            'content-type': 'application/json',
          },
          body: jsonEncode(request),
        )
        .timeout(const Duration(seconds: 60));
  } catch (e) {
    throw VerifierUnavailable('request failed: $e');
  }
  if (response.statusCode != 200) {
    final body = response.body;
    throw VerifierUnavailable(
      'HTTP ${response.statusCode}: '
      '${body.length > 300 ? body.substring(0, 300) : body}',
    );
  }
  return response.body;
}

/// The input of the first tool call in a Messages API response body.
Map<Object?, Object?> toolInputOf(String body) {
  final Object? decoded;
  try {
    decoded = jsonDecode(body);
  } catch (_) {
    throw VerifierUnavailable('response is not JSON');
  }
  final content = decoded is Map ? decoded['content'] : null;
  if (content is! List) throw VerifierUnavailable('no content');
  for (final block in content) {
    if (block is Map && block['type'] == 'tool_use') {
      final input = block['input'];
      if (input is Map) return input;
      break;
    }
  }
  throw VerifierUnavailable('no tool_use block');
}

String buildPrompt(ProofContext c) {
  final handle = c.instagramHandle == null
      ? ''
      : ' Its Instagram account is @${c.instagramHandle}.';
  final business =
      'The business is "${c.shopName}".$handle The student received: '
      '"${c.offerTitle}".';
  final ask = switch (c.proofType) {
    ProofType.igStory =>
      'Is this a screenshot of an Instagram STORY that tags or names this '
          'business?',
    ProofType.igPost =>
      'Is this a screenshot of an Instagram feed POST that tags or names this '
          'business?',
    ProofType.googleReview =>
      'Is this a screenshot of a Google review of this business, with the '
          'business name and a star rating or review text visible?',
    ProofType.tiktok =>
      'Is this a screenshot of a TikTok video or post that mentions this '
          'business?',
  };
  // Gifted-product posts must say so (Turkey's Advertising Board guideline
  // for social-media influencers; FTC/ASA rules say the same elsewhere).
  // Reviews are left out: a review must not be a paid ad at all.
  final disclosure = c.proofType == ProofType.googleReview
      ? ''
      : '\n\nThe post must also disclose that the product was a gift or an '
            'ad: a visible #işbirliği, #isbirligi, #reklam, #ad, #gifted, '
            '#hediye or #sponsored, or Instagram\'s "Paid partnership" / '
            '"Ücretli ortaklık" label. Reject with reason "no_disclosure" if '
            'the business is tagged but no such disclosure is visible.';
  return '$business\n\n$ask$disclosure\n\n'
      'Reject with reason "no_mention" if the business name/tag is missing, '
      '"not_a_post" if it is not that kind of post at all, "unreadable" if you '
      'cannot read the image. Call report_verdict.';
}

/// Parses a Messages API response body into a verdict.
ProofVerdict parseResponse(String body) {
  final input = toolInputOf(body);
  if (input['approved'] == true) return const ProofVerdict.approved();
  return ProofVerdict.rejected(switch (input['reason']) {
    'no_mention' => RejectReason.noMention,
    'no_disclosure' => RejectReason.noDisclosure,
    'not_a_post' => RejectReason.notAPost,
    _ => RejectReason.unreadable,
  });
}

/// JPEG/PNG/WebP by magic bytes; null for anything else.
String? imageMediaType(Uint8List b) {
  if (b.length > 3 && b[0] == 0xFF && b[1] == 0xD8 && b[2] == 0xFF) {
    return 'image/jpeg';
  }
  if (b.length > 8 &&
      b[0] == 0x89 &&
      b[1] == 0x50 &&
      b[2] == 0x4E &&
      b[3] == 0x47) {
    return 'image/png';
  }
  if (b.length > 12 &&
      String.fromCharCodes(b.sublist(0, 4)) == 'RIFF' &&
      String.fromCharCodes(b.sublist(8, 12)) == 'WEBP') {
    return 'image/webp';
  }
  return null;
}
