import 'dart:io';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

/// Gzips the Flutter web app's static files (main.dart.js is ~4 MB raw,
/// ~1 MB gzipped) for browsers that accept it. The compressed bytes are kept
/// in memory per path, so each file is compressed once per server start.
///
/// Only touches successful GETs of compressible types without a Range
/// header; API calls and uploads never go through the web server.
Middleware gzipStaticFiles() {
  final cache = <String, Uint8List>{};
  return (Handler next) {
    return (Request req) async {
      final result = await next(req);
      if (result is! Response ||
          req.method != Method.get ||
          result.statusCode != 200 ||
          req.headers['range'] != null ||
          result.headers['content-encoding'] != null ||
          !(req.headers['accept-encoding']?.join(',').contains('gzip') ??
              false)) {
        return result;
      }
      final type = result.body.bodyType;
      if (type == null || !_compressible(type.mimeType.toString())) {
        return result;
      }
      final length = result.body.contentLength;
      if (length != null && length < 1024) return result;

      final key = '${req.url.path}:$length';
      var zipped = cache[key];
      if (zipped == null) {
        final raw = BytesBuilder(copy: false);
        await for (final chunk in result.body.read()) {
          raw.add(chunk);
        }
        zipped = Uint8List.fromList(gzip.encode(raw.takeBytes()));
        cache[key] = zipped;
      } else {
        // Drain the unused body so the file handle is released.
        await result.body.read().drain<void>();
      }
      return result.copyWith(
        body: Body.fromData(
          zipped,
          mimeType: type.mimeType,
          encoding: type.encoding,
        ),
        headers: result.headers.transform((h) {
          h['content-encoding'] = ['gzip'];
          h['vary'] = ['Accept-Encoding'];
        }),
      );
    };
  };
}

bool _compressible(String mime) =>
    mime.startsWith('text/') ||
    mime.contains('javascript') ||
    mime.contains('json') ||
    mime.contains('wasm') ||
    mime.contains('svg') ||
    mime.contains('font') ||
    mime.contains('ttf') ||
    mime.contains('otf');
