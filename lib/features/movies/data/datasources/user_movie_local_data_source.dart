import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/user_movie_entry.dart';

class UserMovieStats {
  final int wantToWatch;
  final int watched;
  final int dropped;
  final int rated;
  final double averageRating;

  const UserMovieStats({
    required this.wantToWatch,
    required this.watched,
    required this.dropped,
    required this.rated,
    required this.averageRating,
  });
}

class UserMovieLocalDataSource {
  static const _entriesKey = 'user_movie_entries';

  final SharedPreferences _preferences;

  UserMovieLocalDataSource(this._preferences);

  Future<UserMovieEntry?> getEntry(int movieId) async {
    return _readEntries()[movieId.toString()];
  }

  Future<List<UserMovieEntry>> getEntriesByStatus(
    UserMovieStatus status,
  ) async {
    final entries = _readEntries()
        .values
        .where((entry) => entry.status == status)
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return entries;
  }

  Future<UserMovieStats> getStats() async {
    final entries = _readEntries().values.toList();
    final ratedEntries = entries.where((entry) => entry.rating > 0).toList();
    final ratingSum = ratedEntries.fold<int>(
      0,
      (sum, entry) => sum + entry.rating,
    );

    return UserMovieStats(
      wantToWatch: entries
          .where((entry) => entry.status == UserMovieStatus.wantToWatch)
          .length,
      watched: entries
          .where((entry) => entry.status == UserMovieStatus.watched)
          .length,
      dropped: entries
          .where((entry) => entry.status == UserMovieStatus.dropped)
          .length,
      rated: ratedEntries.length,
      averageRating: ratedEntries.isEmpty ? 0 : ratingSum / ratedEntries.length,
    );
  }

  Future<void> saveEntry(UserMovieEntry entry) async {
    final entries = _readEntries();
    entries[entry.movie.id.toString()] = entry;
    await _writeEntries(entries);
  }

  Map<String, UserMovieEntry> _readEntries() {
    final encoded = _preferences.getString(_entriesKey);
    if (encoded == null || encoded.isEmpty) return {};

    final decoded = jsonDecode(encoded) as Map<String, dynamic>;
    return decoded.map(
      (key, value) => MapEntry(
        key,
        _entryFromJson(value as Map<String, dynamic>),
      ),
    );
  }

  Future<void> _writeEntries(Map<String, UserMovieEntry> entries) {
    final encoded = jsonEncode(
      entries.map((key, value) => MapEntry(key, _entryToJson(value))),
    );
    return _preferences.setString(_entriesKey, encoded);
  }

  UserMovieEntry _entryFromJson(Map<String, dynamic> json) {
    return UserMovieEntry(
      movie: Movie(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview'] as String?,
        posterPath: json['posterPath'] as String?,
        releaseDate: json['releaseDate'] as String?,
        voteAverage: (json['voteAverage'] as num?)?.toDouble() ?? 0,
        popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
        genreIds: (json['genreIds'] as List<dynamic>? ?? [])
            .map((id) => id as int)
            .toList(),
      ),
      status: UserMovieStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => UserMovieStatus.wantToWatch,
      ),
      rating: json['rating'] as int? ?? 0,
      notes: json['notes'] as String? ?? '',
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> _entryToJson(UserMovieEntry entry) {
    return {
      'id': entry.movie.id,
      'title': entry.movie.title,
      'overview': entry.movie.overview,
      'posterPath': entry.movie.posterPath,
      'releaseDate': entry.movie.releaseDate,
      'voteAverage': entry.movie.voteAverage,
      'popularity': entry.movie.popularity,
      'genreIds': entry.movie.genreIds,
      'status': entry.status.name,
      'rating': entry.rating,
      'notes': entry.notes,
      'updatedAt': entry.updatedAt.toIso8601String(),
    };
  }
}
