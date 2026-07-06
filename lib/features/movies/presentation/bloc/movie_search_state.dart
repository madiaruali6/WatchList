import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';

/// Состояния — это то, что видит UI. BLoC всегда находится ровно
/// в одном из этих состояний в любой момент времени.
abstract class MovieSearchState extends Equatable {
  final String query;

  const MovieSearchState({this.query = ''});

  @override
  List<Object?> get props => [query];
}

/// Начальное состояние — пользователь ещё ничего не искал
class MovieSearchInitial extends MovieSearchState {
  final List<String> history;
  final List<Movie> recentlyViewed;

  const MovieSearchInitial({
    super.query = '',
    this.history = const [],
    this.recentlyViewed = const [],
  });

  @override
  List<Object?> get props => [query, history, recentlyViewed];
}

/// Идёт загрузка
class MovieSearchLoading extends MovieSearchState {
  const MovieSearchLoading({required super.query});
}

/// Успешно получили результаты
class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;
  final int page;
  final bool hasReachedEnd;
  final bool isLoadingMore;
  final String? loadMoreError;

  const MovieSearchLoaded({
    required super.query,
    required this.movies,
    this.page = 1,
    this.hasReachedEnd = false,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  MovieSearchLoaded copyWith({
    List<Movie>? movies,
    int? page,
    bool? hasReachedEnd,
    bool? isLoadingMore,
    String? loadMoreError,
    bool clearLoadMoreError = false,
  }) {
    return MovieSearchLoaded(
      query: query,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError:
          clearLoadMoreError ? null : loadMoreError ?? this.loadMoreError,
    );
  }

  @override
  List<Object?> get props => [
        query,
        movies,
        page,
        hasReachedEnd,
        isLoadingMore,
        loadMoreError,
      ];
}

/// Произошла ошибка
class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError({required super.query, required this.message});

  @override
  List<Object?> get props => [query, message];
}
