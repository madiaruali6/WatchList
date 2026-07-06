import 'package:equatable/equatable.dart';
import '../../domain/entities/watchlist_item.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistLoading extends WatchlistState {
  const WatchlistLoading();
}

class WatchlistLoaded extends WatchlistState {
  final List<WatchlistItem> items;

  const WatchlistLoaded(this.items);

  bool contains(int movieId) => items.any((item) => item.movieId == movieId);

  @override
  List<Object?> get props => [items];
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}
