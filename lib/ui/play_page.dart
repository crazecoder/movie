import 'package:flutter/material.dart';

import '../utils/string_util.dart';
import '../config.dart';
import '../utils/log_print.dart';
import '../presenter/play_presenter.dart';
import 'package:video_launcher/video_launcher.dart';
import 'dart:async';

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
        child: new CircularProgressIndicator(),
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
      launchVideo(url).then((_) {
        Navigator.pop(context);
      });
    } else {
      throw 'Could not launch $url';
    }
  }
}

abstract class PlayPageStateIml {
  void play(String _url);

  String getPath();
}
