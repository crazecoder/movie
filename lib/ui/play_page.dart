import 'package:flutter/material.dart';

import '../utils/string_util.dart';
import '../utils/log_print.dart';
import '../presenter/play_presenter.dart';
import '../video_laucher.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import '../application.dart';

class PlayPage extends StatefulWidget {
  final String url;
  final String title;

  PlayPage({this.url, this.title});

  @override
  State<StatefulWidget> createState() => new _PlayPageState();
}

class _PlayPageState extends State<PlayPage> implements PlayPageStateIml {
  PlayPresenter _presenter;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: new Center(
        child: new Image.asset("images/load.gif"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _presenter = new PlayPresenter(this);
    _presenter.start();
  }

  @override
  void dispose() {
    super.dispose();
    _presenter?.clear();
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
    _launchURL(_url);
  }

  _launchURL(String _url) async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      showErrorText();
      close();
    }
  }

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
