import 'dart:convert';
import 'package:atelierul_digital_tema5/src/models/movie.dart';
import 'package:http/http.dart';

class MovieApi {
  MovieApi(this._client);

  final Client _client;

  Future<List<Movie>> getMovies(int currentPage) async {
    final String url = 'https://yts.mx/api/v2/list_movies.json/?page=$currentPage';
    final Response response = await _client.get(Uri.parse(url));
    final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> data = body['data'] as Map<String, dynamic>;
    return (data['movies'] as List<dynamic>)
        .map((dynamic item) => Movie.fromJson(item as Map<dynamic, dynamic>))
        .toList();
  }
}
