import '../ui/new_detail_page.dart';
import '../logic/new_detail_logic.dart';
import 'package:html/dom.dart';

abstract class NewDetailPresenterIml {
  void start(Element element);
}

class NewDetailPresenter implements NewDetailPresenterIml {
  NewDetailLogic _logic;
  final NewDetailPageStateIml _view;

  NewDetailPresenter(this._view) {
    _logic = new NewDetailLogic();
  }

  @override
  void start(Element element) {
    _view?.refreshGrid(_logic?.parseHtml(element));
  }
}
