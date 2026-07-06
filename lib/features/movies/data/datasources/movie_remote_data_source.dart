import 'package:dio/dio.dart';
import '../models/movie_model.dart';

/// Data source — единственное место, которое реально знает про
/// конкретные endpoint'ы TMDB API. Ничего не знает про domain.
class MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSource(this.dio);

  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query, 'page': page},
    );
    final parsed = MovieSearchResponseModel.fromJson(response.data);
    return parsed.results;
  }

  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );
    final parsed = MovieSearchResponseModel.fromJson(response.data);
    return parsed.results;
  }
}
