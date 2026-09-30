import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../generated/protocol.dart';
import 'proof_verifier.dart';

/// Stable reject keys, mapped to UI copy on the client.
const studentCardReasons = [
  'not_a_student_card',
  'name_mismatch',
  'school_mismatch',
  'expired',
  'unreadable',
];
const businessDocumentReasons = [
  'not_a_business_document',
  'name_mismatch',
  'unreadable',
];

class DocumentVerdict {
  const DocumentVerdict.approved() : approved = true, reason = null;
  const DocumentVerdict.rejected(String this.reason) : approved = false;

  final bool approved;
  final String? reason;
}

/// What the verifier compares the photo with.
class DocumentContext {
  const DocumentContext({
    required this.image,
    required this.mediaType,
    required this.kind,
    required this.name,
    required this.detail,
    required this.today,
  });

  final Uint8List image;
  final String mediaType;
  final VerificationKind kind;

  /// The student's name, or the place's name.
  final String name;

  /// The student's university, or the place's address.
  final String detail;

  /// Istanbul date, "2026-09-30", to judge expiry.
  final String today;
}

abstract interface class DocumentVerifier {
  Future<DocumentVerdict> verify(DocumentContext context);
}

/// Claude via the Messages API, answer forced into a tool call. It only
/// returns approved + reason: no ID numbers or other card data are asked
/// for or stored.
class AnthropicDocumentVerifier implements DocumentVerifier {
  AnthropicDocumentVerifier({
    required this.apiKey,
    this.model = AnthropicProofVerifier.defaultModel,
    http.Client? client,
  }) : _http = client ?? http.Client();

  static const _tool = 'report_verdict';

  final String apiKey;
  final String model;
  final http.Client _http;

  @override
  Future<DocumentVerdict> verify(DocumentContext c) async =>
      parseDocumentResponse(
        await postToClaude(_http, apiKey, _request(c)),
        c.kind,
      );

  Map<String, Object?> _request(DocumentContext c) {
    final reasons = c.kind == VerificationKind.studentCard
        ? studentCardReasons
        : businessDocumentReasons;
    return {
      'model': model,
      'max_tokens': 300,
      'system':
          'You check photos that users of a student-discount app upload to '
          'prove who they are. Judge only what the photo shows. Never repeat '
          'ID numbers or other personal data. If the photo is clearly edited, '
          'a screen of another photo of a different document, or a template, '
          'reject it. If unsure, reject.',
      'tools': [
        {
          'name': _tool,
          'description': 'Report the verdict for the photo.',
          'input_schema': {
            'type': 'object',
            'properties': {
              'approved': {'type': 'boolean'},
              'reason': {
                'type': ['string', 'null'],
                'enum': [...reasons, null],
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
            {'type': 'text', 'text': buildDocumentPrompt(c)},
          ],
        },
      ],
    };
  }
}

String buildDocumentPrompt(DocumentContext c) => switch (c.kind) {
  VerificationKind.studentCard =>
    'A student says they are "${c.name}" and study at "${c.detail}" (they '
        'typed the university themselves, so it may be abbreviated, in '
        'English or in Turkish). Today is ${c.today}.\n\n'
        'Is this a photo of a university student ID card (a physical card or '
        'the university\'s official digital card / e-Devlet student '
        'certificate) belonging to this person?\n\n'
        'Reject with "not_a_student_card" if it is not a student card (e.g. a '
        'national ID, staff card, library card or a random picture), '
        '"name_mismatch" if the name on it is clearly a different person '
        '(ignore letter case, Turkish letters and missing middle names), '
        '"school_mismatch" if it is clearly a different university, '
        '"expired" if a validity date or academic year on it ended before '
        'today (no date shown is fine), "unreadable" if you cannot read '
        'the name or the university. Call report_verdict.',
  VerificationKind.businessDocument =>
    'A business on the app is called "${c.name}" and its address is '
        '"${c.detail}".\n\n'
        'Is this a photo of an official document of this business: a Turkish '
        'tax certificate (vergi levhası), a workplace licence (işyeri açma ve '
        'çalışma ruhsatı), a trade registry record (ticaret sicil gazetesi), '
        'a chamber of commerce/craftsmen registration certificate, or an '
        'equivalent official document from another country?\n\n'
        'Its legal trade name (ünvan) often differs from the name on the '
        'sign, so approve when EITHER the name plausibly matches OR the '
        'address matches (same street and district is enough).\n\n'
        'Reject with "not_a_business_document" if it is not such a document '
        '(e.g. a receipt, menu, business card or photo of the shop), '
        '"name_mismatch" if neither the name nor the address match, '
        '"unreadable" if you cannot read it. Call report_verdict.',
};

DocumentVerdict parseDocumentResponse(String body, VerificationKind kind) {
  final input = toolInputOf(body);
  if (input['approved'] == true) return const DocumentVerdict.approved();
  final allowed = kind == VerificationKind.studentCard
      ? studentCardReasons
      : businessDocumentReasons;
  final reason = input['reason'];
  return DocumentVerdict.rejected(
    reason is String && allowed.contains(reason) ? reason : 'unreadable',
  );
}
