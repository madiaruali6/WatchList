import 'package:equatable/equatable.dart';

import 'movie.dart';

enum UserMovieStatus {
  wantToWatch,
  watching,
  watched,
  dropped,
}

class UserMovieEntry extends Equatable {
  final Movie movie;
  final UserMovieStatus status;
  final int rating;
  final String notes;
  final DateTime updatedAt;

  const UserMovieEntry({
    required this.movie,
    required this.status,
    this.rating = 0,
    this.notes = '',
    required this.updatedAt,
  });

  UserMovieEntry copyWith({
    Movie? movie,
    UserMovieStatus? status,
    int? rating,
    String? notes,
    DateTime? updatedAt,
  }) {
    return UserMovieEntry(
      movie: movie ?? this.movie,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [movie, status, rating, notes, updatedAt];
}
