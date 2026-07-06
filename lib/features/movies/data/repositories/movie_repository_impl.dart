import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

/// Реализация интерфейса из domain. Здесь и только здесь происходит
/// обработка ошибок сети и превращение MovieModel -> Movie.
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final models = await remoteDataSource.searchMovies(query);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
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
}
