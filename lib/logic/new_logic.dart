import '../utils/my_isolate.dart';
import '../utils/html_parse.dart';
import '../http/movie_http.dart';
import '../bean/category.dart';

class NewLogic implements NewLogicIml{

  @override
  void getData(Function fn) {
    MovieHttpClient().getHtml().then((_html) async{
      List<Category> _categorys =  await compute(parseNewHomeTab,_html);
      fn(_categorys);
    });
  }

}
abstract class NewLogicIml{
  void getData(Function fn);
}