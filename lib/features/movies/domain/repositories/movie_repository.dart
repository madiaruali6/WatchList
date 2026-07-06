import '../entities/movie.dart';

/// Интерфейс — domain слой описывает ЧТО нужно делать,
/// а КАК это делается (через Dio, через кэш и т.д.) решает data слой.
/// Presentation и domain зависят только от этого абстрактного класса,
/// никогда от конкретной реализации.
abstract class MovieRepository {
  Future<List<Movie>> searchMovies(String query, {int page = 1});
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<String>> getSearchHistory();
  Future<int> getSearchesCount();
  Future<List<Movie>> getRecentlyViewed();
  Future<int> getViewedMoviesCount();
  Future<void> markRecentlyViewed(Movie movie);
}
