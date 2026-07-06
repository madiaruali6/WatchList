import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../models/movie_model.dart';

class MovieLocalDataSource {
  final AppDatabase database;

  MovieLocalDataSource(this.database);

  Future<void> cacheSearchResults({
    required String query,
    required List<MovieModel> movies,
  }) async {
    final normalizedQuery = _normalizeQuery(query);
    final now = DateTime.now();

    await database.transaction(() async {
      await addSearchHistory(normalizedQuery);

      await (database.delete(database.cachedSearchResults)
            ..where((row) => row.query.equals(normalizedQuery)))
          .go();

      for (var index = 0; index < movies.length; index++) {
        final movie = movies[index];
        await database.into(database.cachedMovies).insertOnConflictUpdate(
              _movieToCompanion(movie, now),
            );
        await database
            .into(database.cachedSearchResults)
            .insertOnConflictUpdate(
              CachedSearchResultsCompanion(
                query: Value(normalizedQuery),
                movieId: Value(movie.id),
                position: Value(index),
                cachedAt: Value(now),
              ),
            );
      }
    });
  }

  Future<List<MovieModel>> getCachedSearchResults(String query) async {
    final normalizedQuery = _normalizeQuery(query);
    final rows = await (database.select(database.cachedSearchResults)
          ..where((row) => row.query.equals(normalizedQuery))
          ..orderBy([(row) => OrderingTerm.asc(row.position)]))
        .join([
      innerJoin(
        database.cachedMovies,
        database.cachedMovies.movieId.equalsExp(
          database.cachedSearchResults.movieId,
        ),
      ),
    ]).get();

    return rows
        .map((row) => _cachedMovieToModel(row.readTable(database.cachedMovies)))
        .toList();
  }

  Future<void> addSearchHistory(String query) async {
    final normalizedQuery = _normalizeQuery(query);
    if (normalizedQuery.isEmpty) return;

    await database.into(database.searchHistoryEntries).insertOnConflictUpdate(
          SearchHistoryEntriesCompanion(
            query: Value(normalizedQuery),
            searchedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<List<String>> getSearchHistory({int limit = 8}) async {
    final rows = await (database.select(database.searchHistoryEntries)
          ..orderBy([(row) => OrderingTerm.desc(row.searchedAt)])
          ..limit(limit))
        .get();

    return rows.map((row) => row.query).toList();
  }

  Future<int> getSearchesCount() async {
    final count = database.searchHistoryEntries.query.count();
    final query = database.selectOnly(database.searchHistoryEntries)
      ..addColumns([count]);
    return await query.map((row) => row.read(count) ?? 0).getSingle();
  }

  Future<void> markRecentlyViewed(MovieModel movie) async {
    final now = DateTime.now();
    await database.transaction(() async {
      await database.into(database.cachedMovies).insertOnConflictUpdate(
            _movieToCompanion(movie, now),
          );
      await database.into(database.recentMovieEntries).insertOnConflictUpdate(
            RecentMovieEntriesCompanion(
              movieId: Value(movie.id),
              viewedAt: Value(now),
            ),
          );
    });
  }

  Future<List<MovieModel>> getRecentlyViewed({int limit = 10}) async {
    final rows = await (database.select(database.recentMovieEntries)
          ..orderBy([(row) => OrderingTerm.desc(row.viewedAt)])
          ..limit(limit))
        .join([
      innerJoin(
        database.cachedMovies,
        database.cachedMovies.movieId.equalsExp(
          database.recentMovieEntries.movieId,
        ),
      ),
    ]).get();

    return rows
        .map((row) => _cachedMovieToModel(row.readTable(database.cachedMovies)))
        .toList();
  }

  Future<int> getViewedMoviesCount() async {
    final count = database.recentMovieEntries.movieId.count();
    final query = database.selectOnly(database.recentMovieEntries)
      ..addColumns([count]);
    return await query.map((row) => row.read(count) ?? 0).getSingle();
  }

  String _normalizeQuery(String query) => query.trim().toLowerCase();

  CachedMoviesCompanion _movieToCompanion(MovieModel movie, DateTime cachedAt) {
    return CachedMoviesCompanion(
      movieId: Value(movie.id),
      title: Value(movie.title),
      overview: Value(movie.overview),
      posterPath: Value(movie.posterPath),
      releaseDate: Value(movie.releaseDate),
      voteAverage: Value(movie.voteAverage),
      popularity: Value(movie.popularity),
      genreIds: Value(movie.genreIds.join(',')),
      cachedAt: Value(cachedAt),
    );
  }

  MovieModel _cachedMovieToModel(CachedMovy movie) {
    final genreIds = movie.genreIds
        .split(',')
        .where((id) => id.isNotEmpty)
        .map(int.parse)
        .toList();

    return MovieModel(
      id: movie.movieId,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      popularity: movie.popularity,
      genreIds: genreIds,
    );
  }
}
