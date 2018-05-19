import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bean/video.dart';
import '../application.dart';
import '../presenter/new_detail_presenter.dart';
import '../utils/string_util.dart';
import 'package:html/dom.dart' as dom;

///最近更新分栏
class NewDetailPage extends StatefulWidget {
  final dom.Element element;

  NewDetailPage(this.element);

  @override
  State<StatefulWidget> createState() => new _NewDetailPageState();
}

class _NewDetailPageState extends State<NewDetailPage>
    implements NewDetailPageStateIml {
  List<Movie> _movies = <Movie>[];
  NewDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new NewDetailPresenter(this);
    _presenter.start(widget.element);
  }

  @override
  Widget build(BuildContext context) {
    if (_movies.length > 1) {
      return new GridView.builder(
        itemCount: _movies?.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: const EdgeInsets.all(4.0),
        itemBuilder: (_, i) {
          return _buildGridItem(_movies[i]);
        },
      );
    } else {
      return new Center(
        child:  new Image.asset("images/load.gif"),
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
                placeholder:  new Image.asset("images/load.gif"),
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
  void refreshGrid(List<Movie> _moviesData) {
    setState(() {
      if (mounted) _movies = _moviesData;
    });
  }
}

abstract class NewDetailPageStateIml {
  void refreshGrid(List<Movie> _moviesData);
}
