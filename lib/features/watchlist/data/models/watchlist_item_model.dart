import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/watchlist_item.dart';

/// Модель данных — знает, как превратиться в Map для Firestore и обратно.
/// Firestore не работает через JSON напрямую, поэтому здесь ручной
/// fromMap/toMap вместо freezed+json_serializable.
class WatchlistItemModel {
  final int movieId;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final DateTime addedAt;

  const WatchlistItemModel({
    required this.movieId,
    required this.title,
    this.posterPath,
    this.voteAverage = 0.0,
    required this.addedAt,
  });

  factory WatchlistItemModel.fromMap(Map<String, dynamic> map) {
    return WatchlistItemModel(
      movieId: map['movieId'] as int,
      title: map['title'] as String,
      posterPath: map['posterPath'] as String?,
      voteAverage: (map['voteAverage'] as num?)?.toDouble() ?? 0.0,
      addedAt: (map['addedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movieId': movieId,
      'title': title,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }

  WatchlistItem toEntity() {
    return WatchlistItem(
      movieId: movieId,
      title: title,
      posterPath: posterPath,
      voteAverage: voteAverage,
      addedAt: addedAt,
    );
  }

  factory WatchlistItemModel.fromEntity(WatchlistItem entity) {
    return WatchlistItemModel(
      movieId: entity.movieId,
      title: entity.title,
      posterPath: entity.posterPath,
      voteAverage: entity.voteAverage,
      addedAt: entity.addedAt,
    );
  }
}
