import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../utils/string_util.dart';
import '../config.dart';
import '../utils/log_print.dart';
import '../http/movie_http.dart';


class PlayPage extends StatefulWidget {
  final String url;
  final String title;

  PlayPage({this.url, this.title});

  @override
  State<StatefulWidget> createState() => new _PlayPageState();
}

class _PlayPageState extends State<PlayPage> implements PlayPageStateIml {
  WebviewScaffold _webview;
  GlobalKey _webviewKey = new GlobalKey();
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  Widget build(BuildContext context) {
    _webview = new WebviewScaffold(
      key: _webviewKey,
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      url: _parseUrl(),
      appBar: AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
    );
    return _webview;
  }

  @override
  void initState() {
    super.initState();
//    MovieHttpClient().getHtml(path: StringUtil.decodeUrl(widget.url));
  }
  @override
  void dispose() {
    super.dispose();
    _webviewKey?.currentState?.dispose();

  }
  @override
  void play() {}

  String _parseUrl() {
    String path = StringUtil.decodeUrl(widget.url);
    String url = Config.URL + path;
    log(url);
    return url;
  }
}

abstract class PlayPageStateIml {
  void play();
}
