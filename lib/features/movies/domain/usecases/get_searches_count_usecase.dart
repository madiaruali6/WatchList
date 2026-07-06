import '../repositories/movie_repository.dart';

class GetSearchesCountUseCase {
  final MovieRepository repository;

  GetSearchesCountUseCase(this.repository);

  Future<int> call() {
    return repository.getSearchesCount();
  }
}
