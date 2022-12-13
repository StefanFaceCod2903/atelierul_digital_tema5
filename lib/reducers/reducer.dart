import 'package:atelierul_digital_tema5/actions/index.dart';
import 'package:atelierul_digital_tema5/src/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesStart>(_getMoviesStart),
  TypedReducer<AppState, SetSelectedMovie>(_setSelectedMovie),
  TypedReducer<AppState, SetCurrentPage>(_setCurrentPage)
]);

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.copyWith(
    currentPage: state.currentPage + 1,
    isLoading: false,
    movies: <Movie>[
      if (state.currentPage != 1) ...state.movies,
      ...action.movies,
    ],
  );
}

AppState _getMoviesStart(AppState state, GetMoviesStart action) {
  return state.copyWith(
    isLoading: true,
  );
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.copyWith(
    isLoading: false,
  );
}

AppState _setSelectedMovie(AppState state, SetSelectedMovie action) {
  return state.copyWith(
    selectedMovie: action.movie,
  );
}

AppState _setCurrentPage(AppState state, SetCurrentPage action) {
  return state.copyWith(
    currentPage: action.newPage,
  );
}
