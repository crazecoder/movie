import 'package:flutter/material.dart';
import '../bean/tab_item.dart';
import '../presenter/home_presenter.dart';
import '../ui/new_page.dart';
import '../ui/movie_grid_page.dart';

///首页框架
class MovieHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MovieHomeState();
}

abstract class MovieHomeStateIml {
  void refreshTabs(List<MovieTabItem> _items);
}

class _MovieHomeState extends State<MovieHome>
    with TickerProviderStateMixin
    implements MovieHomeStateIml {
  var _currentIndex = 0;
  var _tabs = <MovieTabItem>[];
  TabController _controller;
  HomePresenter _presenter;

  @override
  void initState() {
    _controller = new TabController(length: _tabs.length, vsync: this);
    _presenter = new HomePresenter(this);
    _presenter.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
//          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _tabChanged,
          items: _tabs
              .map((_tab) =>
                  _buildBottomNavigationBarItem(_tab.title, _tab.icon))
              .toList()),
      body: new TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: _tabs
              .map((_tab) =>
                  _tab.url.length > 1 ? new MovieGridPage(_tab) : new NewPage())
              .toList()),
//      body: new Stack(
//        children: _tabs.map((_tab) => _buildOffstage(_tab.title)).toList(),
//      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String _title, IconData _iconData) {
    return new BottomNavigationBarItem(
        backgroundColor: Theme.of(context).primaryColor,
        icon: new Icon(_iconData),
        title: new Text(_title));
  }

  Widget _buildOffstage(String _title) {
    return new Offstage(
      offstage: _title != _tabs[_currentIndex].title,
      child: new NewPage(),
    );
  }

  void _tabChanged(int _index) {
    setState(() {
      _currentIndex = _index;
      _controller.index = _index;
      print("_index=$_index");
      print(" _controller.index =${_controller.index}");
    });
  }

  @override
  void refreshTabs(List<MovieTabItem> _items) {
    setState(() {
      _tabs = _items;
      _controller = new TabController(length: _tabs.length, vsync: this);
    });
  }
}
