import 'package:equatable/equatable.dart';
import '../../domain/entities/watchlist_item.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

/// Подписаться на живой список фильмов (вызывается один раз при открытии)
class WatchlistSubscriptionRequested extends WatchlistEvent {
  const WatchlistSubscriptionRequested();
}

/// Внутреннее событие — обновление списка пришло из стрима Firestore
class WatchlistUpdated extends WatchlistEvent {
  final List<WatchlistItem> items;

  const WatchlistUpdated(this.items);

  @override
  List<Object?> get props => [items];
}

class AddMovieToWatchlist extends WatchlistEvent {
  final WatchlistItem item;

  const AddMovieToWatchlist(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveMovieFromWatchlist extends WatchlistEvent {
  final int movieId;

  const RemoveMovieFromWatchlist(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
