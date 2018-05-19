import '../http/movie_http.dart';
import '../utils/my_isolate.dart';
import '../utils/html_parse.dart';

abstract class PlayLogicIml {
  void getPlay(Function fn, String _path);
}

class PlayLogic implements PlayLogicIml {
  @override
  void getPlay(Function fn, String _path) {
    MovieHttpClient().getHtml(path: _path).then((_html) {
      compute(parseJS, _html).then((_url) {
        MovieHttpClient().getHtmlFromJS(_url).then((_html) {
          compute(parseUrlFromJS, _html).then((_url) {
            MovieHttpClient().getHtmlFromJS(_url).then((_html) {
              compute(parsePlayUrl, _html).then((_url) {
                MovieHttpClient().getHtmlFromJS(_url).then((_html) {
                  compute(parsePlayUrlFromHtml, _html).then((_playUrl) {
                    fn(_playUrl);
                  });
                });
              });
            });
          });
        });
      });
    });
  }
}
