import 'dart:async';

abstract class SplashLogicIml{
  void startTimer(Function _handTimer);
  void stopTimer();
}
class SplashLogic implements SplashLogicIml{
  Timer _timer;
  @override
  void startTimer(Function _handTimer) {
    const timeout = const Duration(seconds: 3);
    _timer = new Timer(timeout, _handTimer);
  }

  @override
  void stopTimer() {
    _timer?.cancel();
  }

}