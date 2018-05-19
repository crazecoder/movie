import '../ui/play_page.dart';
import '../logic/play_logic.dart';

abstract class PlayPresenterIml {
  void start();
}

class PlayPresenter implements PlayPresenterIml {
  final PlayPageStateIml _view;
  PlayLogic _logic;

  PlayPresenter(this._view) {
    _logic = new PlayLogic();
  }

  @override
  void start() {
    _logic.getPlay((_url) {
      _view.play(_url);
    }, _view.getPath());
  }
}
