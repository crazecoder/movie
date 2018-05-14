import 'dart:async';
import '../bean/video.dart';
import '../http/movie_http.dart';
import '../utils/my_isolate.dart';
import '../utils/html_parse.dart';

abstract class MovieLogicIml {
  void refreshMovies(String _path,Function fn);

  void loadMoreMovies(String _path,Function fn);
}

class MovieLogic implements MovieLogicIml {
  @override
  Future loadMoreMovies(String _path,Function fn) {
    return MovieHttpClient().getHtml(path: _path).then((_html) async{
      List<Movie> _movies = await compute(parseNewDetail, parseMovieGrid(_html).element);
      fn(_movies);
    });
  }

  @override
  Future refreshMovies(String _path, Function fn)  {
    return MovieHttpClient().getHtml(path: _path).then((_html) async{
      List<Movie> _movies = await compute(parseNewDetail, parseMovieGrid(_html).element);
      fn(_movies);
    });
  }
}
