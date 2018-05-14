import 'package:html/dom.dart';
import '../utils/html_parse.dart';
import '../bean/video.dart';

abstract class NewDetailLogicIml{
  List<Movie> parseHtml(Element element);
}
class NewDetailLogic implements NewDetailLogicIml{
  @override
  List<Movie> parseHtml(Element element) {
    return parseNewDetail(element);
  }
}