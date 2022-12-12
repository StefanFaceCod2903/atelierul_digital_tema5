part of 'index.dart';

@freezed
class GetMovie with _$GetMovie {
  const factory GetMovie() = GetMovieStart;

  const factory GetMovie.successful(List<Movie> movies) = GetMovieSuccesful;

  const factory GetMovie.error(Object error, StackTrace stackTrace) =
      GetMovieError;
}
