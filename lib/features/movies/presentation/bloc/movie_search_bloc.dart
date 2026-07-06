import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_movies_usecase.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

/// BLoC = связующее звено между UI и use case.
/// UI шлёт Event -> BLoC вызывает use case -> BLoC отдаёт новый State -> UI перерисовывается.
class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  // Храним текущий запрос, чтобы игнорировать устаревшие ответы
  // (если пользователь быстро печатает, не хотим, чтобы старый
  // медленный ответ перезаписал новый результат)
  String _latestQuery = '';

  MovieSearchBloc(this.searchMoviesUseCase)
      : super(const MovieSearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
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

    // Debounce: ждём 400мс тишины перед реальным запросом,
    // чтобы не слать запрос на каждую напечатанную букву
    await Future.delayed(const Duration(milliseconds: 400));

    // Если за время ожидания пользователь напечатал что-то ещё —
    // этот запрос устарел, прерываем
    if (_latestQuery != event.query) return;

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
}
