import 'dart:async';

import 'package:http/http.dart';
//import 'package:http_client/console.dart';
//import '../http/my_client.dart' as http;
import '../utils/log_print.dart';
import '../config.dart';
import 'dart:convert';

class MovieHttpClient {
  static final MovieHttpClient _httpClient = MovieHttpClient._internal();

  final _url = Config.URL;

  MovieHttpClient._internal();

  factory MovieHttpClient() {
    return _httpClient;
  }

  Future<String> getHtml({String path = ""}) async {
    if (path.isNotEmpty) {
      path = path.substring(1);
    }
    log('$_url$path');
    var client = new IOClient();
    Request request = new Request("GET", Uri.parse('$_url$path'));
//    request.encoding=Encoding.getByName("utf-8");
//    request.headers['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8";
//    request.headers['Accept-Encoding'] = 'gzip, deflate';
//    request.headers['Accept-Language'] = 'zh-CN,zh;q=0.9';
//    request.headers['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36';
//    log(request.headers);
    StreamedResponse streamedResponse =
        await client.send(request);
//    Response response =  await Response.fromStream(streamedResponse);
//    log(response.headers);

    String body = await Utf8Codec(allowMalformed:true).decodeStream(streamedResponse.stream);
    log(body);
    return body;
  }
  Future<String> getHtmlFromJS(String _jsUrl) async {
    log('$_jsUrl');
    var client = new IOClient();
    Request request = new Request("GET", Uri.parse(_jsUrl));
//    request.encoding=Encoding.getByName("utf-8");
//    request.headers['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8";
//    request.headers['Accept-Encoding'] = 'gzip, deflate';
//    request.headers['Accept-Language'] = 'zh-CN,zh;q=0.9';
//    request.headers['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36';
//    log(request.headers);
    StreamedResponse streamedResponse =
    await client.send(request);
//    Response response =  await Response.fromStream(streamedResponse);
//    log(response.headers);

    String body = await Utf8Codec(allowMalformed:true).decodeStream(streamedResponse.stream);
    log(body);
    return body;
  }
//  Future<String> getHtml({String path = ""}) async {
//    if (path.isNotEmpty) {
//      path = path.substring(1);
//    }
//    log('$_url$path');
//    final _client = new ConsoleClient();
//    Request request = new Request('GET', '$_url$path', headers: {"accept-charset": "UTF-8"});
//    log(request.headers.toSimpleMap());
//    final rs = await _client.send(request);
//    log(rs.headers.toSimpleMap());
//    final String textContent = await rs.readAsString();
//    log(textContent);
//    await _client.close();
//    return textContent;
//  }

//  void close() {
//    _client?.close();
//  }
}
