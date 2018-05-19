import 'package:flutter/material.dart';
import 'new_detail_page.dart';
import '../presenter/new_presenter.dart';
import '../utils/log_print.dart';
import '../bean/category.dart';

///最近更新
class NewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NewPageState();
}

class _NewPageState extends State<NewPage>
    with TickerProviderStateMixin
    implements NewPageStateIml {
  TabController _controller;
  var _categorys = <Category>[];
  NewPresenter _presenter;

  @override
  Widget build(BuildContext context) {
    if (_categorys.length > 1) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text("最近更新"),
          centerTitle: true,
          bottom: TabBar(
            tabs: _categorys.map((_category) {
              log(_category.name);
              return new Tab(
                text: _category.name,
              );
            }).toList(),
            isScrollable: true,
            controller: _controller,
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: _categorys.map((_category) {
            return new NewDetailPage(_category.element);
          }).toList(),
        ),
      );
    } else {
      return new Scaffold(
        appBar: AppBar(
          title: new Text("最近更新"),
          centerTitle: true,
        ),
        body: new Center(
          child:  new Image.asset("images/load.gif"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _presenter = new NewPresenter(this);
    _presenter.start();
  }


  @override
  void refresh(List<Category> _categorys) {
    setState(() {
      this._categorys = _categorys;
      _controller = new TabController(length: _categorys.length, vsync: this);
    });
  }
}

abstract class NewPageStateIml {
  void refresh(List<Category> _categorys);
}
