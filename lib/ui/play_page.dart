import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _PlayPageState();

}
class _PlayPageState extends State<PlayPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text("111");
  }

}
abstract class PlayPageStateIml{
  void play();
}