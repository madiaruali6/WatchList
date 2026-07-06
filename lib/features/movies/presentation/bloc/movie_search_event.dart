import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';

/// События — это ДЕЙСТВИЯ пользователя, которые отправляются в BLoC.
/// UI никогда не меняет состояние напрямую — только шлёт событие.
abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object?> get props => [];
}

class MovieSearchStarted extends MovieSearchEvent {
  const MovieSearchStarted();
}

class SearchQueryChanged extends MovieSearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchNextPageRequested extends MovieSearchEvent {
  const SearchNextPageRequested();
}

class MovieViewed extends MovieSearchEvent {
  final Movie movie;

  const MovieViewed(this.movie);

  @override
  List<Object?> get props => [movie];
}
