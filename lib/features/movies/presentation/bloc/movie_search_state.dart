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
  const MovieSearchInitial({super.query = ''});
}

/// Идёт загрузка
class MovieSearchLoading extends MovieSearchState {
  const MovieSearchLoading({required super.query});
}

/// Успешно получили результаты
class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;

  const MovieSearchLoaded({required super.query, required this.movies});

  @override
  List<Object?> get props => [query, movies];
}

/// Произошла ошибка
class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError({required super.query, required this.message});

  @override
  List<Object?> get props => [query, message];
}
