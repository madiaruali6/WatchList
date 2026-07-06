import 'package:equatable/equatable.dart';

/// Фильм, сохранённый пользователем в личный список.
class WatchlistItem extends Equatable {
  final int movieId;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final DateTime addedAt;

  const WatchlistItem({
    required this.movieId,
    required this.title,
    this.posterPath,
    this.voteAverage = 0.0,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [movieId, title, posterPath, voteAverage, addedAt];
}
