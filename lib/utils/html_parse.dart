import 'dart:async';

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import '../utils/log_print.dart';
import '../bean/category.dart';
import '../bean/video.dart';
import '../bean/movie_detail.dart';

Future<Null> parseHome(String homeHtml) async {
//  var doc = parse(homeHtml);
//  List<Element> els =
//  doc.documentElement.getElementsByClassName("navbar-header");
//  List<Element> lis = els?.first?.getElementsByTagName("li");
//  log('${lis.length}');
//  lis.forEach((element) {
//    Element a = element.getElementsByTagName("a").first;
//    log(a?.innerHtml);
//  });
}

List<Category> parseNewHomeTab(String newHtml) {
  var _categorys = <Category>[];
  var doc = parse(newHtml);
  Element container =
      doc?.documentElement?.getElementsByClassName("container")?.last;
  List<Element> rows = container?.getElementsByClassName("row");
  log('${rows.length}');
  rows.forEach((element) {
    Element h3 = element?.getElementsByTagName("h3")?.first;
    var _title = h3.innerHtml.replaceAll("：", "");
    var _category = new Category(name: _title, element: element);
    _categorys.add(_category);
  });
  return _categorys;
}
Category parseMovieGrid(String newHtml) {
  var doc = parse(newHtml);
  Element container =
      doc?.documentElement?.getElementsByClassName("container")?.last;
  var _category = new Category(element: container);

  return _category;
}

List<Movie> parseNewDetail(Element element) {
  var _movies = <Movie>[];
  List<Element> items = element?.getElementsByClassName("movie-item");
  log('${items.length}');
  items.forEach((element) {
    Element a = element?.getElementsByTagName("a")?.first;
    String name = a?.attributes["title"];
    String path = a?.attributes["href"];
    Element img = a?.getElementsByTagName("img")?.first;
    String picture = img?.attributes["src"];
    if (!picture.contains("http:") && !picture.contains("https:")) {
      picture = "http:" + picture;
    }
    var _movie = new Movie(url: path, name: name, picture: picture);
    _movies.add(_movie);
  });
  return _movies;
}
MovieDetail parseMovieDetail(String _html) {
  var _movies = <Movie>[];
  var doc = parse(_html);
  Element summary =
      doc?.documentElement?.getElementsByClassName("summary")?.first;
  Element group =
      doc?.documentElement?.getElementsByClassName("dslist-group")?.first;
  String intro = summary?.innerHtml;
  List<Element> as = group?.getElementsByTagName("a");
  log('${as.length}');
  as.forEach((a) {
    var _name = a.innerHtml;
    var _url = a.attributes["href"];
    Movie _movie = new Movie(name: _name,url: _url);
    _movies.add(_movie);
  });
  var _movieDetail = new MovieDetail(intro: intro,movies: _movies);
  return _movieDetail;
}
