import '../logic/home_logic.dart';
import '../ui/home.dart';
abstract class HomePresenterIml{
  void start();
}
class HomePresenter implements HomePresenterIml{
  HomeLogic _logic;
  final MovieHomeStateIml _view;
  HomePresenter(this._view){
    _logic= new HomeLogic();
  }
  @override
  void start() {
    _view?.refreshTabs(_logic?.getTabItems());
  }

}