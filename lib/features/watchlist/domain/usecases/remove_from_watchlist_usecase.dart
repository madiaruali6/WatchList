import '../repositories/watchlist_repository.dart';

class RemoveFromWatchlistUseCase {
  final WatchlistRepository repository;

  RemoveFromWatchlistUseCase(this.repository);

  Future<void> call(String userId, int movieId) {
    return repository.removeFromWatchlist(userId, movieId);
  }
}
