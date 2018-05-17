import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'ui/home.dart';
import 'ui/play_page.dart';
import 'ui/movie_detail_page.dart';
import 'application.dart';

class Routers {
  static const HOME = "/home";
  static const DETAIL = "/detail";
  static const DETAIL_ROUTER = DETAIL + "/:url/:title/:picture";
  static const PLAY = "/play";
  static const PLAY_ROUTER = PLAY + "/:url/:title";

  static void init() {
    final Router router = new Router();
    router.define(
      HOME,
      handler: new Handler(
        handlerFunc: (context, Map<String, dynamic> params) {
          return new MovieHome();
        },
      ),
    );
    router.define(
      DETAIL_ROUTER,
      handler: new Handler(
        handlerFunc: (context, Map<String, dynamic> params) {
          return new MovieDetailPage(
            url: params["url"][0],
            title: params["title"][0],
            picture: params["picture"][0],
          );
        },
      ),
    );
    router.define(
      PLAY_ROUTER,
      handler: new Handler(
        handlerFunc: (context, Map<String, dynamic> params) {
          return new PlayPage(
            url: params["url"][0],
            title: params["title"][0],
          );
        },
      ),
    );
    Application.router = router;
  }
}
