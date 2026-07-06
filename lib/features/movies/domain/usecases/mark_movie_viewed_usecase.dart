import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class MarkMovieViewedUseCase {
  final MovieRepository repository;

  MarkMovieViewedUseCase(this.repository);

  Future<void> call(Movie movie) {
    return repository.markRecentlyViewed(movie);
  }
}
