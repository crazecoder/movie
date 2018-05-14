import '../bean/movie_detail.dart';
import '../http/movie_http.dart';
import '../utils/html_parse.dart';
import '../utils/my_isolate.dart';

abstract class MovieDetailLogicIml {
  void getMovieDetail(String path,Function fn);
}

class MovieDetailLogic implements MovieDetailLogicIml {
  @override
  void getMovieDetail(String path,Function fn) {
    MovieHttpClient().getHtml(path: path).then((_html) async {
      MovieDetail _movieDetail = await compute(parseMovieDetail, _html);
      fn(_movieDetail);
    });
  }
}
