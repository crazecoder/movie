// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:http/http.dart';

/// A `dart:io`-based HTTP client.
///
/// This is the default client when running on the command line.
class MyClient extends IOClient {
  Future<Response> get(url, {Map<String, String> headers}) =>
      _sendUnstreamed("GET", url, headers);

  /// Sends a non-streaming [Request] and returns a non-streaming [Response].
  Future<Response> _sendUnstreamed(String method, url,
      Map<String, String> headers, [body, Encoding encoding]) async {
    if (url is String) url = Uri.parse(url);
    var request = new Request(method, url);

    if (headers != null) {
      request.headers.addAll(headers);
    }
//    request.encoding = Encoding.getByName("utf-8");
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = DelegatingList.typed(body);
      } else if (body is Map) {
        request.bodyFields = DelegatingMap.typed(body);
      } else {
        throw new ArgumentError('Invalid request body "$body".');
      }
    }

    return Response.fromStream(await send(request));
  }
}

