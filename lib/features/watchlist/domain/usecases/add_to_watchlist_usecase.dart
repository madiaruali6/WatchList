import '../entities/watchlist_item.dart';
import '../repositories/watchlist_repository.dart';

class AddToWatchlistUseCase {
  final WatchlistRepository repository;

  AddToWatchlistUseCase(this.repository);

  Future<void> call(String userId, WatchlistItem item) {
    return repository.addToWatchlist(userId, item);
  }
}
