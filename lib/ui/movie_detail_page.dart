import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bean/video.dart';
import '../bean/movie_detail.dart';
import '../presenter/movie_detail_presenter.dart';
import '../utils/string_util.dart';
import '../application.dart';
import '../routers.dart';

class MovieDetailPage extends StatefulWidget {
  final String title;
  final String picture;
  final String url;

  MovieDetailPage({this.url, this.title, this.picture});

  @override
  State<StatefulWidget> createState() => new _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    implements MovieDetailPageStateIml {
  String _intro = "";
  var _items = <Movie>[];
  MovieDetailPresenter _presenter;
  GlobalKey<ScaffoldState> _key = new GlobalKey();

  @override
  void initState() {
    super.initState();
    _presenter = new MovieDetailPresenter(this);
    String _path = StringUtil.decodeUrl(widget.url);
    _presenter.start(_path);
  }

  @override
  Widget build(BuildContext context) {
    if (_intro.isEmpty || _items?.length == 0) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text(widget.title),
          centerTitle: true,
        ),
        body: new Center(
          child:  new Image.asset("images/load.gif"),
        ),
      );
    } else
      return new Scaffold(
        key: _key,
        appBar: AppBar(
          title: new Text(widget.title),
          centerTitle: true,
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new CachedNetworkImage(
                  imageUrl: StringUtil.decodeUrl(widget.picture)),
              new Text(_intro),
              new Container(
                height: 40.0,
                child: new ListView.builder(
                    itemCount: _items?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) {
                      return new RaisedButton(
                        onPressed: () {
                          Application.router.navigateTo(context,
                              "${Routers.PLAY}/${StringUtil.encodeUrl(_items[i]?.url)}/${widget.title}");
                        },
                        child: new Container(
                          child: new Text(_items[i]?.name),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
  }

  @override
  void refresh(MovieDetail _movieDetail) {
    setState(() {
      _intro = _movieDetail.intro;
      _items = _movieDetail.movies;
      Application.key = _key;
    });
  }
}

abstract class MovieDetailPageStateIml {
  void refresh(MovieDetail _movieDetail);
}
