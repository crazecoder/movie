import 'package:flutter/material.dart';

import '../utils/string_util.dart';
import '../utils/log_print.dart';
import '../presenter/play_presenter.dart';
import '../video_laucher.dart';
import 'dart:async';
import '../application.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PlayPage extends StatefulWidget {
  final String url;
  final String title;

  PlayPage({this.url, this.title});

  @override
  State<StatefulWidget> createState() => new _PlayPageState();
}

class _PlayPageState extends State<PlayPage> implements PlayPageStateIml {
  PlayPresenter _presenter;
  bool _complete = false;
  BoxConstraints _box;
  GlobalKey _key = new GlobalKey();
  GlobalKey _appBarKey = new GlobalKey();
  Size _size;
  Size _appBarSize;
  StreamSubscription _onDestroy;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  final kAndroidUserAgent =
      "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        key: _appBarKey,
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
//    if(_complete){
//      _box = new BoxConstraints.expand();
//      return new ConstrainedBox(constraints: _box);
//    }else{
      return new Center(
        key: _key,
        child: new Image.asset("images/load.gif"),
      );
//    }
  }
  @override
  void initState() {
    super.initState();
    _presenter = new PlayPresenter(this);
    _presenter.start();
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        dispose();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _presenter?.clear();
    _onDestroy.cancel();
    flutterWebviewPlugin.close();
  }

  @override
  void play(String _url) {
    _launch(_url);
  }

  @override
  String getPath() {
    String path = StringUtil.decodeUrl(widget.url);
    log(path);
    return path;
  }

  Future<Null> _launch(String url) async {
    if (await canLaunchVideo(url)) {
      await launchVideo(url);
    } else {
      showErrorText();
      close();
    }
  }

  @override
  void close() {
    Navigator.pop(context);
  }

  @override
  void loadWebView(String _url) {
    setState(() {
      _complete = true;
      _size = _key.currentContext?.findRenderObject()?.semanticBounds?.size;
      _appBarSize = _appBarKey.currentContext?.findRenderObject()?.semanticBounds?.size;
    });
    flutterWebviewPlugin.launch(_url,
        withJavascript: true,
        rect: new Rect.fromLTWH(0.0, _appBarSize?.height, _size?.width, _size?.height),
        userAgent: kAndroidUserAgent);

//    _launchURL(_url);
  }

//  _launchURL(String _url) async {
//    if (await canLaunch(_url)) {
//      await launch(_url);
//    } else {
//      showErrorText();
//      close();
//    }
//  }

  @override
  void showErrorText() {
    Application.key?.currentState?.showSnackBar(new SnackBar(
        content: new Row(
      children: <Widget>[
        new Container(
          child: new Icon(Icons.error_outline),
          margin: new EdgeInsets.all(5.0),
        ),
        new Text("解析失败"),
      ],
    )));
  }
}

abstract class PlayPageStateIml {
  void play(String _url);

  void loadWebView(String _url);

  void close();

  void showErrorText();

  String getPath();
}
