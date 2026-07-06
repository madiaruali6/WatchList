import '../../domain/entities/watchlist_item.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/watchlist_remote_data_source.dart';
import '../models/watchlist_item_model.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remoteDataSource;

  WatchlistRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<WatchlistItem>> watchlistStream(String userId) {
    return remoteDataSource
        .watchlistStream(userId)
        .map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<void> addToWatchlist(String userId, WatchlistItem item) {
    return remoteDataSource.addToWatchlist(
      userId,
      WatchlistItemModel.fromEntity(item),
    );
  }

  @override
  Future<void> removeFromWatchlist(String userId, int movieId) {
    return remoteDataSource.removeFromWatchlist(userId, movieId);
  }

  @override
  Future<bool> isInWatchlist(String userId, int movieId) {
    return remoteDataSource.isInWatchlist(userId, movieId);
  }
}
