import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class CachedMovies extends Table {
  IntColumn get movieId => integer()();
  TextColumn get title => text()();
  TextColumn get overview => text().nullable()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get releaseDate => text().nullable()();
  RealColumn get voteAverage => real().withDefault(const Constant(0))();
  RealColumn get popularity => real().withDefault(const Constant(0))();
  TextColumn get genreIds => text().withDefault(const Constant(''))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {movieId};
}

class CachedSearchResults extends Table {
  TextColumn get query => text()();
  IntColumn get movieId => integer()();
  IntColumn get position => integer()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {query, movieId};
}

class SearchHistoryEntries extends Table {
  TextColumn get query => text()();
  DateTimeColumn get searchedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {query};
}

class RecentMovieEntries extends Table {
  IntColumn get movieId => integer()();
  DateTimeColumn get viewedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {movieId};
}

@DriftDatabase(
  tables: [
    CachedMovies,
    CachedSearchResults,
    SearchHistoryEntries,
    RecentMovieEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(cachedMovies, cachedMovies.popularity);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cine_vault.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
