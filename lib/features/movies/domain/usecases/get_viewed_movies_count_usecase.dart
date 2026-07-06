import '../repositories/movie_repository.dart';

class GetViewedMoviesCountUseCase {
  final MovieRepository repository;

  GetViewedMoviesCountUseCase(this.repository);

  Future<int> call() {
    return repository.getViewedMoviesCount();
  }
}
