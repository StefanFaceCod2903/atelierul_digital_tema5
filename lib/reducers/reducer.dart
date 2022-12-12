import 'package:atelierul_digital_tema5/actions/index.dart';
import 'package:atelierul_digital_tema5/src/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetMovieError>(_getMovieError),
  TypedReducer<AppState, GetMovieSuccesful>(_getMovieSuccessful),
  TypedReducer<AppState, GetMovieStart>(_getMovieStart),
  TypedReducer<AppState, SetSelectedMovie>(_setSelectedMovie),
]);

AppState _getMovieSuccessful(AppState state, GetMovieSuccesful action) {
  return state.copyWith(
    currentPage: state.currentPage + 1,
    isLoading: false,
    movies: <Movie>[
      ...state.movies,
      ...action.movies,
    ],
  );
}

AppState _getMovieStart(AppState state, GetMovieStart action) {
  return state.copyWith(
    isLoading: true,
  );
}

AppState _getMovieError(AppState state, GetMovieError action) {
  return state.copyWith(
    isLoading: false,
  );
}

AppState _setSelectedMovie(AppState state, SetSelectedMovie action) {
  return state.copyWith(
    selectedMovie: action.movie,
  );
}
