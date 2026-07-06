import 'package:equatable/equatable.dart';

/// События — это ДЕЙСТВИЯ пользователя, которые отправляются в BLoC.
/// UI никогда не меняет состояние напрямую — только шлёт событие.
abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends MovieSearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
