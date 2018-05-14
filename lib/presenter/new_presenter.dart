import '../ui/new_page.dart';
import '../logic/new_logic.dart';

abstract class NewPresenterIml{
  void start();
  void _doRefresh();
}
class NewPresenter implements NewPresenterIml{
  final NewPageStateIml _view;
  NewLogic _logic;
  NewPresenter(this._view){
    _logic = new NewLogic();
  }

  @override
  void start() {
    _doRefresh();
  }

  @override
  void _doRefresh() {
    _logic?.getData((_categorys){
      _view.refresh(_categorys);
    });
  }

}