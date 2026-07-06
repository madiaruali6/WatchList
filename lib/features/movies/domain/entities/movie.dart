import 'package:equatable/equatable.dart';

/// Чистая бизнес-модель фильма.
/// НЕ знает про JSON, про API, про Firestore — просто данные + Equatable
/// (Equatable нужен, чтобы Movie можно было сравнивать через == , это
/// важно для BLoC state, чтобы виджет не перерисовывался зря).
class Movie extends Equatable {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final double voteAverage;
  final List<int> genreIds;

  const Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.voteAverage = 0.0,
    this.genreIds = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        releaseDate,
        voteAverage,
        genreIds,
      ];
}
