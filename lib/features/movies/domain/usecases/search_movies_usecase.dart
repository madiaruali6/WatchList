import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

/// Use case = один конкретный сценарий использования приложения.
/// "Пользователь ищет фильм по названию" — это и есть один use case.
///
/// Зачем это нужно, если можно вызвать repository.searchMovies() напрямую
/// из BLoC? На маленьком проекте разница не видна, но это приучает
/// держать бизнес-логику (например: "не искать, если запрос короче
/// 2 символов") ОТДЕЛЬНО от репозитория и ОТДЕЛЬНО от UI.
class SearchMoviesUseCase {
  final MovieRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<List<Movie>> call(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.length < 2) {
      return [];
    }
    return repository.searchMovies(trimmedQuery);
  }
}
