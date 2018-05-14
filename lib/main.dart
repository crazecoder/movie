import 'package:flutter/material.dart';
import 'config.dart';
import 'ui/splash.dart';
import 'routers.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Routers.init();
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: Config.IS_DEBUG,
      home: new SplashPage(),
    );
  }
}

