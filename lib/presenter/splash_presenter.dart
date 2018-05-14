import '../ui/splash.dart';
import '../logic/splash_logic.dart';

abstract class SplashPresenterIml {
  void start();

  void stop();
}

class SplashPresenter implements SplashPresenterIml {
  final SplashPageIml _view;
  SplashLogic _logic;

  SplashPresenter(this._view) {
    _logic = new SplashLogic();
  }

  @override
  void start() {
    _logic?.startTimer(_view?.navigateToHome);
  }

  @override
  void stop() {
    _logic?.stopTimer();
  }
}
