import '../ui/play_page.dart';
import '../logic/play_logic.dart';
import 'dart:async';


abstract class PlayPresenterIml {
  void start();
  void clear();
}

class PlayPresenter implements PlayPresenterIml {
  final PlayPageStateIml _view;
  PlayLogic _logic;
  Timer _timer;
  PlayPresenter(this._view) {
    _logic = new PlayLogic();
  }

  @override
  void start() {
    _logic.getPlay((_url) {
      _timer = new Timer(new Duration(seconds: 1), _view.close);
      _view.play(_url);
    }, _view.getPath());
  }

  @override
  void clear() {
    _timer?.cancel();
  }
}
