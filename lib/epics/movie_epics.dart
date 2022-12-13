import 'package:atelierul_digital_tema5/actions/index.dart';
import 'package:atelierul_digital_tema5/data/movie_api.dart';
import 'package:atelierul_digital_tema5/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/transformers.dart';

class AppEpics {
  AppEpics(this._api);

  final MovieApi _api;

  Epic<AppState> get epic {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, GetMoviesStart>(_getMoviesStart),
    ]);
  }

  Stream<dynamic> _getMoviesStart(
    Stream<GetMoviesStart> actions,
    EpicStore<AppState> store,
  ) {
    return actions
        .asyncMap(
          (GetMoviesStart action) => _api.getMovies(store.state.currentPage),
        )
        .map((List<Movie> movies) => GetMovies.successful(movies))
        .onErrorReturnWith(
          (Object error, StackTrace stackTrace) =>
              GetMoviesError(error, stackTrace),
        );
  }
}
