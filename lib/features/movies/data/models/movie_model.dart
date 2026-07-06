import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

/// Модель данных — знает про JSON (в отличие от domain Movie).
/// Умеет превращаться в чистую доменную сущность через toEntity().
@freezed
class MovieModel with _$MovieModel {
  const MovieModel._(); // нужен, чтобы добавить метод toEntity() ниже

  const factory MovieModel({
    required int id,
    required String title,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @Default(0.0) double popularity,
    @JsonKey(name: 'genre_ids') @Default([]) List<int> genreIds,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  /// Превращает модель данных в чистую доменную сущность
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      popularity: popularity,
      genreIds: genreIds,
    );
  }
}

/// Обёртка над ответом TMDB (пагинация + список фильмов)
@freezed
class MovieSearchResponseModel with _$MovieSearchResponseModel {
  const factory MovieSearchResponseModel({
    required int page,
    required List<MovieModel> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _MovieSearchResponseModel;

  factory MovieSearchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieSearchResponseModelFromJson(json);
}
