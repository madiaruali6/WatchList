import '../entities/watchlist_item.dart';

abstract class WatchlistRepository {
  /// Живой список фильмов пользователя — обновляется сам,
  /// как только что-то меняется в Firestore
  Stream<List<WatchlistItem>> watchlistStream(String userId);

  Future<void> addToWatchlist(String userId, WatchlistItem item);

  Future<void> removeFromWatchlist(String userId, int movieId);

  /// Проверить, есть ли уже фильм в списке (для иконки "звёздочка")
  Future<bool> isInWatchlist(String userId, int movieId);
}
