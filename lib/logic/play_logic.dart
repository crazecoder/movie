import '../http/movie_http.dart';
import '../utils/my_isolate.dart';
import '../utils/html_parse.dart';
import 'dart:async';

abstract class PlayLogicIml {
  void getPlay(Function fn, Function fn1, String _path);

  void computeClose();
}

class PlayLogic implements PlayLogicIml {
  @override
  void getPlay(Function fn, Function fn1, String _path) {
    runZoned(() {
      MovieHttpClient().getHtml(path: _path).then((_html) {
        compute(parseJS, _html).then((_url) {
          MovieHttpClient().getHtmlFromJS(_url).then((_html) {
            if (_html.contains("盗链")) {
              fn1();
              return;
            } else if (_html.contains("var flashvars={f:'")) {
              compute(parseOtherPlayUrl, _html).then((_playUrl) {
                fn(_playUrl, true);
                return;
              });
            }
            compute(parseUrlFromJS, _html).then((_url) {
              MovieHttpClient().getHtmlFromJS(_url).then((_html) {
                if (_html.contains("盗链")) {
                  fn1();
                  return;
                } else if (_html.contains("var flashvars={f:'")) {
                  compute(parseOtherPlayUrl, _html).then((_playUrl) {
                    fn(_playUrl, true);
                    return;
                  });
                }
                compute(parsePlayUrl, _html).then((_url) {
                  MovieHttpClient().getHtmlFromJS(_url).then((_html) {
                    if (_html.contains("解析")) {
                      fn(_url, false);
                      return;
                    } else if (_html.contains("var flashvars={f:'")) {
                      compute(parseOtherPlayUrl, _html).then((_playUrl) {
                        fn(_playUrl, true);
                        return;
                      });
                    } else {
                      compute(parsePlayUrlFromHtml, _html).then((_playUrl) {
                        fn(_playUrl, true);
                      });
                    }
                  });
                });
              });
            });
          });
        });
      });
    }, onError: (_) {
      print("getPlay error");
    });
  }

  @override
  void computeClose() {
    close();
  }
}
