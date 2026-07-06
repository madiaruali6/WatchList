import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';
import '../models/movie_model.dart';

/// Реализация интерфейса из domain. Здесь и только здесь происходит
/// обработка ошибок сети и превращение MovieModel -> Movie.
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final models = await remoteDataSource.searchMovies(query);
      await localDataSource.cacheSearchResults(query: query, movies: models);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      final cachedModels = await localDataSource.getCachedSearchResults(query);
      if (cachedModels.isNotEmpty) {
        return cachedModels.map((model) => model.toEntity()).toList();
      }
      throw Exception('Не удалось найти фильмы: $e');
    }
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final models = await remoteDataSource.getPopularMovies(page: page);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Не удалось загрузить популярные фильмы: $e');
    }
  }

  @override
  Future<List<String>> getSearchHistory() {
    return localDataSource.getSearchHistory();
  }

  @override
  Future<List<Movie>> getRecentlyViewed() async {
    final models = await localDataSource.getRecentlyViewed();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> markRecentlyViewed(Movie movie) {
    return localDataSource.markRecentlyViewed(_movieToModel(movie));
  }

  MovieModel _movieToModel(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      genreIds: movie.genreIds,
    );
  }
}
