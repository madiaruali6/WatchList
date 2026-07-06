import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../domain/usecases/get_search_overview_usecase.dart';
import '../../domain/usecases/mark_movie_viewed_usecase.dart';
import '../../domain/usecases/search_movies_usecase.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

/// BLoC = связующее звено между UI и use case.
/// UI шлёт Event -> BLoC вызывает use case -> BLoC отдаёт новый State -> UI перерисовывается.
class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;
  final GetSearchOverviewUseCase getSearchOverviewUseCase;
  final MarkMovieViewedUseCase markMovieViewedUseCase;

  // Храним текущий запрос, чтобы игнорировать устаревшие ответы
  // (если пользователь быстро печатает, не хотим, чтобы старый
  // медленный ответ перезаписал новый результат)
  String _latestQuery = '';

  MovieSearchBloc(
    this.searchMoviesUseCase,
    this.getSearchOverviewUseCase,
    this.markMovieViewedUseCase,
  ) : super(const MovieSearchInitial()) {
    on<MovieSearchStarted>(_onMovieSearchStarted);
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: _debounceRestartable(const Duration(milliseconds: 450)),
    );
    on<MovieViewed>(_onMovieViewed);
  }

  Future<void> _onMovieSearchStarted(
    MovieSearchStarted event,
    Emitter<MovieSearchState> emit,
  ) async {
    final overview = await getSearchOverviewUseCase();
    emit(
      MovieSearchInitial(
        history: overview.history,
        recentlyViewed: overview.recentlyViewed,
      ),
    );
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<MovieSearchState> emit,
  ) async {
    _latestQuery = event.query;

    if (event.query.trim().isEmpty) {
      emit(const MovieSearchInitial());
      return;
    }

    emit(MovieSearchLoading(query: event.query));

    try {
      final movies = await searchMoviesUseCase(event.query);

      // Проверяем ещё раз после await — вдруг запрос сменился
      // пока ждали ответ от сервера
      if (_latestQuery != event.query) return;

      emit(MovieSearchLoaded(query: event.query, movies: movies));
    } catch (e) {
      if (_latestQuery != event.query) return;
      emit(MovieSearchError(query: event.query, message: e.toString()));
    }
  }

  Future<void> _onMovieViewed(
    MovieViewed event,
    Emitter<MovieSearchState> emit,
  ) async {
    await markMovieViewedUseCase(event.movie);
  }

  EventTransformer<E> _debounceRestartable<E>(Duration duration) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}
