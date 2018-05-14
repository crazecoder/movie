import '../logic/movie_detail_logic.dart';
import '../ui/movie_detail_page.dart';

abstract class MovieDetailPresenterIml{
  void start(String path);
}

class MovieDetailPresenter implements MovieDetailPresenterIml{
  final MovieDetailPageStateIml _view;
  MovieDetailLogic _logic;
  MovieDetailPresenter(this._view){
    _logic = new MovieDetailLogic();
  }
  @override
  void start(String path) {
    _logic.getMovieDetail(path, _view.refresh);
  }

}