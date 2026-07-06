import '../entities/watchlist_item.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistStreamUseCase {
  final WatchlistRepository repository;

  GetWatchlistStreamUseCase(this.repository);

  Stream<List<WatchlistItem>> call(String userId) {
    return repository.watchlistStream(userId);
  }
}
