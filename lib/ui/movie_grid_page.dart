import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../bean/video.dart';
import '../widget/pdrpulm.dart';
import '../utils/string_util.dart';
import '../application.dart';
import '../presenter/movie_grid_presenter.dart';
import '../bean/tab_item.dart';

class MovieGridPage extends StatefulWidget {
  final MovieTabItem tabItem;

  MovieGridPage(this.tabItem);

  @override
  State<StatefulWidget> createState() => new _MovieGridPageState();
}

class _MovieGridPageState extends State<MovieGridPage>
    implements MovieGridPageStateIml {
  List<Movie> _movies = <Movie>[];
  MovieGridPresenter _presenter;
  bool _isLoadMoreing = false;
  bool _isRefreshing = false;
  var _page = 1; //页数

  @override
  void initState() {
    super.initState();
    _presenter = new MovieGridPresenter(this);
    _presenter.refreshMovies();
  }

  @override
  Widget build(BuildContext context) {
    if (_movies.length > 1) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text(widget.tabItem.title),
          centerTitle: true,
        ),
        body: new ScrollIndicator(
          onLoadMore: loadMoreMovies,
          onRefresh: refreshMovies,
          child: new GridView.builder(
            itemCount: _movies.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            padding: const EdgeInsets.all(4.0),
            itemBuilder: (_, i) {
              return _buildGridItem(_movies[i]);
            },
          ),
        ),
      );
    } else {
      return new Scaffold(
        appBar: AppBar(
          title: new Text(widget.tabItem.title),
          centerTitle: true,
        ),
        body: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget _buildGridItem(Movie _movie) {
    return new GestureDetector(
      onTap: () {
        String url = StringUtil.encodeUrl(_movie.url);
        String picture = StringUtil.encodeUrl(_movie.picture);
        Application.router
            .navigateTo(context, '/detail/$url/${_movie.name}/$picture');
      },
      child: new Card(
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new CachedNetworkImage(
                imageUrl: _movie.picture,
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Icon(Icons.error),
              ),
            ),
            new Text(
              _movie.name,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void loadComplete(List<Movie> _data) {
    if (_isRefreshing) {
      _isRefreshing = false;
      _page = 1;
    }
    if (_isLoadMoreing) {
      _isLoadMoreing = false;
      _page++;
    }
    setState(() {
      _page == 1 ? _movies = _data : _movies.addAll(_data);
    });
  }

  @override
  Future loadMoreMovies() {
    _isLoadMoreing = true;
    return _presenter.loadMoreMovies();
  }

  @override
  Future refreshMovies() {
    _isRefreshing = true;
    return _presenter.refreshMovies();
  }

  @override
  String getPath() {
    String url = widget.tabItem.url;
    List<String> paths = url.split("/");
    String pagePath = paths[paths.length - 1];
    List<String> pagePaths = pagePath.split(".");
    String pageTag = pagePaths[pagePaths.length - 1];
    String path = '$_page.$pageTag';
    url = url.replaceAll(pagePath, path);
    return url;
  }
}

abstract class MovieGridPageStateIml {
  void refreshMovies();

  void loadMoreMovies();

  void loadComplete(List<Movie> _data);

  String getPath();
}
