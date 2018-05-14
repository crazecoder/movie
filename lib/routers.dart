import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'ui/home.dart';
import 'ui/movie_detail_page.dart';
import 'application.dart';

class Routers {
  static const HOME = "/home";
  static const DETAIL = "/detail/:url/:title/:picture";

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
      DETAIL,
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
    Application.router = router;
  }
}
