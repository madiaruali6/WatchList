import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_watchlist_usecase.dart';
import '../../domain/usecases/get_watchlist_stream_usecase.dart';
import '../../domain/usecases/remove_from_watchlist_usecase.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistStreamUseCase getWatchlistStreamUseCase;
  final AddToWatchlistUseCase addToWatchlistUseCase;
  final RemoveFromWatchlistUseCase removeFromWatchlistUseCase;
  final String userId;

  StreamSubscription? _watchlistSubscription;

  WatchlistBloc({
    required this.getWatchlistStreamUseCase,
    required this.addToWatchlistUseCase,
    required this.removeFromWatchlistUseCase,
    required this.userId,
  }) : super(const WatchlistLoading()) {
    on<WatchlistSubscriptionRequested>(_onSubscriptionRequested);
    on<WatchlistUpdated>((event, emit) => emit(WatchlistLoaded(event.items)));
    on<AddMovieToWatchlist>(_onAddMovie);
    on<RemoveMovieFromWatchlist>(_onRemoveMovie);
  }

  void _onSubscriptionRequested(
    WatchlistSubscriptionRequested event,
    Emitter<WatchlistState> emit,
  ) {
    _watchlistSubscription?.cancel();
    _watchlistSubscription = getWatchlistStreamUseCase(userId).listen(
      (items) => add(WatchlistUpdated(items)),
      onError: (_) => add(const WatchlistUpdated([])),
    );
  }

  Future<void> _onAddMovie(
    AddMovieToWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    // Список сам обновится через стрим — здесь просто пишем в Firestore
    await addToWatchlistUseCase(userId, event.item);
  }

  Future<void> _onRemoveMovie(
    RemoveMovieFromWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    await removeFromWatchlistUseCase(userId, event.movieId);
  }

  @override
  Future<void> close() {
    _watchlistSubscription?.cancel();
    return super.close();
  }
}
