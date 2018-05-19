import 'package:flutter/material.dart';
import '../application.dart';
import '../routers.dart';
import '../presenter/splash_presenter.dart';

abstract class SplashPageIml {
  void navigateToHome();
}

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> implements SplashPageIml {
  SplashPresenter _presenter;

  @override
  Widget build(BuildContext context) {
    return new SizedBox.expand(
      child: new DecoratedBox(
        child: new Image.asset("images/splash.gif"),
        decoration: BoxDecoration(
          color:  Colors.white,
//          gradient: LinearGradient(
//            colors: <Color>[Colors.blueGrey, Colors.white70],
//          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _presenter = new SplashPresenter(this);
    _presenter.start();
  }

  @override
  void dispose() {
    super.dispose();
    _presenter?.stop();
  }

  @override
  void navigateToHome() {
    Application.router.navigateTo(context, Routers.HOME, replace: true);
  }
}
