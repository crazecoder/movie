import '../ui/movie_grid_page.dart';
import '../logic/movie_gird_logic.dart';
import 'dart:async';

abstract class MovieGridPresenterIml {
  void refreshMovies();

  void loadMoreMovies();
}

class MovieGridPresenter implements MovieGridPresenterIml {
  MovieGridPageStateIml _view;
  MovieLogic _logic;

  MovieGridPresenter(this._view) {
    _logic = new MovieLogic();
  }

  @override
  Future loadMoreMovies() {
     return _logic.loadMoreMovies(_view.getPath(),_view.loadComplete);
  }

  @override
  Future refreshMovies() {
    return _logic.refreshMovies(_view.getPath(),_view.loadComplete);
  }
}
