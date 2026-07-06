// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedMoviesTable extends CachedMovies
    with TableInfo<$CachedMoviesTable, CachedMovy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMoviesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _overviewMeta =
      const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
      'overview', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _posterPathMeta =
      const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
      'poster_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'release_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _genreIdsMeta =
      const VerificationMeta('genreIds');
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
      'genre_ids', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        movieId,
        title,
        overview,
        posterPath,
        releaseDate,
        voteAverage,
        genreIds,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_movies';
  @override
  VerificationContext validateIntegrity(Insertable<CachedMovy> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    }
    if (data.containsKey('genre_ids')) {
      context.handle(_genreIdsMeta,
          genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {movieId};
  @override
  CachedMovy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMovy(
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}movie_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      overview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overview']),
      posterPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster_path']),
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}release_date']),
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average'])!,
      genreIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre_ids'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedMoviesTable createAlias(String alias) {
    return $CachedMoviesTable(attachedDatabase, alias);
  }
}

class CachedMovy extends DataClass implements Insertable<CachedMovy> {
  final int movieId;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final double voteAverage;
  final String genreIds;
  final DateTime cachedAt;
  const CachedMovy(
      {required this.movieId,
      required this.title,
      this.overview,
      this.posterPath,
      this.releaseDate,
      required this.voteAverage,
      required this.genreIds,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['movie_id'] = Variable<int>(movieId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || overview != null) {
      map['overview'] = Variable<String>(overview);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    map['vote_average'] = Variable<double>(voteAverage);
    map['genre_ids'] = Variable<String>(genreIds);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedMoviesCompanion toCompanion(bool nullToAbsent) {
    return CachedMoviesCompanion(
      movieId: Value(movieId),
      title: Value(title),
      overview: overview == null && nullToAbsent
          ? const Value.absent()
          : Value(overview),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      voteAverage: Value(voteAverage),
      genreIds: Value(genreIds),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedMovy.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMovy(
      movieId: serializer.fromJson<int>(json['movieId']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String?>(json['overview']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      genreIds: serializer.fromJson<String>(json['genreIds']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'movieId': serializer.toJson<int>(movieId),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String?>(overview),
      'posterPath': serializer.toJson<String?>(posterPath),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'genreIds': serializer.toJson<String>(genreIds),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedMovy copyWith(
          {int? movieId,
          String? title,
          Value<String?> overview = const Value.absent(),
          Value<String?> posterPath = const Value.absent(),
          Value<String?> releaseDate = const Value.absent(),
          double? voteAverage,
          String? genreIds,
          DateTime? cachedAt}) =>
      CachedMovy(
        movieId: movieId ?? this.movieId,
        title: title ?? this.title,
        overview: overview.present ? overview.value : this.overview,
        posterPath: posterPath.present ? posterPath.value : this.posterPath,
        releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
        voteAverage: voteAverage ?? this.voteAverage,
        genreIds: genreIds ?? this.genreIds,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedMovy copyWithCompanion(CachedMoviesCompanion data) {
    return CachedMovy(
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
      title: data.title.present ? data.title.value : this.title,
      overview: data.overview.present ? data.overview.value : this.overview,
      posterPath:
          data.posterPath.present ? data.posterPath.value : this.posterPath,
      releaseDate:
          data.releaseDate.present ? data.releaseDate.value : this.releaseDate,
      voteAverage:
          data.voteAverage.present ? data.voteAverage.value : this.voteAverage,
      genreIds: data.genreIds.present ? data.genreIds.value : this.genreIds,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMovy(')
          ..write('movieId: $movieId, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('genreIds: $genreIds, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(movieId, title, overview, posterPath,
      releaseDate, voteAverage, genreIds, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMovy &&
          other.movieId == this.movieId &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.posterPath == this.posterPath &&
          other.releaseDate == this.releaseDate &&
          other.voteAverage == this.voteAverage &&
          other.genreIds == this.genreIds &&
          other.cachedAt == this.cachedAt);
}

class CachedMoviesCompanion extends UpdateCompanion<CachedMovy> {
  final Value<int> movieId;
  final Value<String> title;
  final Value<String?> overview;
  final Value<String?> posterPath;
  final Value<String?> releaseDate;
  final Value<double> voteAverage;
  final Value<String> genreIds;
  final Value<DateTime> cachedAt;
  const CachedMoviesCompanion({
    this.movieId = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.cachedAt = const Value.absent(),
  });
  CachedMoviesCompanion.insert({
    this.movieId = const Value.absent(),
    required String title,
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.genreIds = const Value.absent(),
    required DateTime cachedAt,
  })  : title = Value(title),
        cachedAt = Value(cachedAt);
  static Insertable<CachedMovy> custom({
    Expression<int>? movieId,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? posterPath,
    Expression<String>? releaseDate,
    Expression<double>? voteAverage,
    Expression<String>? genreIds,
    Expression<DateTime>? cachedAt,
  }) {
    return RawValuesInsertable({
      if (movieId != null) 'movie_id': movieId,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (genreIds != null) 'genre_ids': genreIds,
      if (cachedAt != null) 'cached_at': cachedAt,
    });
  }

  CachedMoviesCompanion copyWith(
      {Value<int>? movieId,
      Value<String>? title,
      Value<String?>? overview,
      Value<String?>? posterPath,
      Value<String?>? releaseDate,
      Value<double>? voteAverage,
      Value<String>? genreIds,
      Value<DateTime>? cachedAt}) {
    return CachedMoviesCompanion(
      movieId: movieId ?? this.movieId,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      voteAverage: voteAverage ?? this.voteAverage,
      genreIds: genreIds ?? this.genreIds,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMoviesCompanion(')
          ..write('movieId: $movieId, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('genreIds: $genreIds, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }
}

class $CachedSearchResultsTable extends CachedSearchResults
    with TableInfo<$CachedSearchResultsTable, CachedSearchResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedSearchResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
      'query', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [query, movieId, position, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_search_results';
  @override
  VerificationContext validateIntegrity(Insertable<CachedSearchResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query']!, _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    } else if (isInserting) {
      context.missing(_movieIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {query, movieId};
  @override
  CachedSearchResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedSearchResult(
      query: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query'])!,
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}movie_id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedSearchResultsTable createAlias(String alias) {
    return $CachedSearchResultsTable(attachedDatabase, alias);
  }
}

class CachedSearchResult extends DataClass
    implements Insertable<CachedSearchResult> {
  final String query;
  final int movieId;
  final int position;
  final DateTime cachedAt;
  const CachedSearchResult(
      {required this.query,
      required this.movieId,
      required this.position,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['query'] = Variable<String>(query);
    map['movie_id'] = Variable<int>(movieId);
    map['position'] = Variable<int>(position);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedSearchResultsCompanion toCompanion(bool nullToAbsent) {
    return CachedSearchResultsCompanion(
      query: Value(query),
      movieId: Value(movieId),
      position: Value(position),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedSearchResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedSearchResult(
      query: serializer.fromJson<String>(json['query']),
      movieId: serializer.fromJson<int>(json['movieId']),
      position: serializer.fromJson<int>(json['position']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'query': serializer.toJson<String>(query),
      'movieId': serializer.toJson<int>(movieId),
      'position': serializer.toJson<int>(position),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedSearchResult copyWith(
          {String? query, int? movieId, int? position, DateTime? cachedAt}) =>
      CachedSearchResult(
        query: query ?? this.query,
        movieId: movieId ?? this.movieId,
        position: position ?? this.position,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedSearchResult copyWithCompanion(CachedSearchResultsCompanion data) {
    return CachedSearchResult(
      query: data.query.present ? data.query.value : this.query,
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
      position: data.position.present ? data.position.value : this.position,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedSearchResult(')
          ..write('query: $query, ')
          ..write('movieId: $movieId, ')
          ..write('position: $position, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(query, movieId, position, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedSearchResult &&
          other.query == this.query &&
          other.movieId == this.movieId &&
          other.position == this.position &&
          other.cachedAt == this.cachedAt);
}

class CachedSearchResultsCompanion extends UpdateCompanion<CachedSearchResult> {
  final Value<String> query;
  final Value<int> movieId;
  final Value<int> position;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedSearchResultsCompanion({
    this.query = const Value.absent(),
    this.movieId = const Value.absent(),
    this.position = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedSearchResultsCompanion.insert({
    required String query,
    required int movieId,
    required int position,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  })  : query = Value(query),
        movieId = Value(movieId),
        position = Value(position),
        cachedAt = Value(cachedAt);
  static Insertable<CachedSearchResult> custom({
    Expression<String>? query,
    Expression<int>? movieId,
    Expression<int>? position,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (query != null) 'query': query,
      if (movieId != null) 'movie_id': movieId,
      if (position != null) 'position': position,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedSearchResultsCompanion copyWith(
      {Value<String>? query,
      Value<int>? movieId,
      Value<int>? position,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CachedSearchResultsCompanion(
      query: query ?? this.query,
      movieId: movieId ?? this.movieId,
      position: position ?? this.position,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedSearchResultsCompanion(')
          ..write('query: $query, ')
          ..write('movieId: $movieId, ')
          ..write('position: $position, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoryEntriesTable extends SearchHistoryEntries
    with TableInfo<$SearchHistoryEntriesTable, SearchHistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
      'query', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _searchedAtMeta =
      const VerificationMeta('searchedAt');
  @override
  late final GeneratedColumn<DateTime> searchedAt = GeneratedColumn<DateTime>(
      'searched_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [query, searchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SearchHistoryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query']!, _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('searched_at')) {
      context.handle(
          _searchedAtMeta,
          searchedAt.isAcceptableOrUnknown(
              data['searched_at']!, _searchedAtMeta));
    } else if (isInserting) {
      context.missing(_searchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {query};
  @override
  SearchHistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistoryEntry(
      query: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query'])!,
      searchedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}searched_at'])!,
    );
  }

  @override
  $SearchHistoryEntriesTable createAlias(String alias) {
    return $SearchHistoryEntriesTable(attachedDatabase, alias);
  }
}

class SearchHistoryEntry extends DataClass
    implements Insertable<SearchHistoryEntry> {
  final String query;
  final DateTime searchedAt;
  const SearchHistoryEntry({required this.query, required this.searchedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['query'] = Variable<String>(query);
    map['searched_at'] = Variable<DateTime>(searchedAt);
    return map;
  }

  SearchHistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoryEntriesCompanion(
      query: Value(query),
      searchedAt: Value(searchedAt),
    );
  }

  factory SearchHistoryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistoryEntry(
      query: serializer.fromJson<String>(json['query']),
      searchedAt: serializer.fromJson<DateTime>(json['searchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'query': serializer.toJson<String>(query),
      'searchedAt': serializer.toJson<DateTime>(searchedAt),
    };
  }

  SearchHistoryEntry copyWith({String? query, DateTime? searchedAt}) =>
      SearchHistoryEntry(
        query: query ?? this.query,
        searchedAt: searchedAt ?? this.searchedAt,
      );
  SearchHistoryEntry copyWithCompanion(SearchHistoryEntriesCompanion data) {
    return SearchHistoryEntry(
      query: data.query.present ? data.query.value : this.query,
      searchedAt:
          data.searchedAt.present ? data.searchedAt.value : this.searchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryEntry(')
          ..write('query: $query, ')
          ..write('searchedAt: $searchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(query, searchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistoryEntry &&
          other.query == this.query &&
          other.searchedAt == this.searchedAt);
}

class SearchHistoryEntriesCompanion
    extends UpdateCompanion<SearchHistoryEntry> {
  final Value<String> query;
  final Value<DateTime> searchedAt;
  final Value<int> rowid;
  const SearchHistoryEntriesCompanion({
    this.query = const Value.absent(),
    this.searchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchHistoryEntriesCompanion.insert({
    required String query,
    required DateTime searchedAt,
    this.rowid = const Value.absent(),
  })  : query = Value(query),
        searchedAt = Value(searchedAt);
  static Insertable<SearchHistoryEntry> custom({
    Expression<String>? query,
    Expression<DateTime>? searchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (query != null) 'query': query,
      if (searchedAt != null) 'searched_at': searchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchHistoryEntriesCompanion copyWith(
      {Value<String>? query, Value<DateTime>? searchedAt, Value<int>? rowid}) {
    return SearchHistoryEntriesCompanion(
      query: query ?? this.query,
      searchedAt: searchedAt ?? this.searchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (searchedAt.present) {
      map['searched_at'] = Variable<DateTime>(searchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryEntriesCompanion(')
          ..write('query: $query, ')
          ..write('searchedAt: $searchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecentMovieEntriesTable extends RecentMovieEntries
    with TableInfo<$RecentMovieEntriesTable, RecentMovieEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentMovieEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _viewedAtMeta =
      const VerificationMeta('viewedAt');
  @override
  late final GeneratedColumn<DateTime> viewedAt = GeneratedColumn<DateTime>(
      'viewed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [movieId, viewedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_movie_entries';
  @override
  VerificationContext validateIntegrity(Insertable<RecentMovieEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    }
    if (data.containsKey('viewed_at')) {
      context.handle(_viewedAtMeta,
          viewedAt.isAcceptableOrUnknown(data['viewed_at']!, _viewedAtMeta));
    } else if (isInserting) {
      context.missing(_viewedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {movieId};
  @override
  RecentMovieEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentMovieEntry(
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}movie_id'])!,
      viewedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}viewed_at'])!,
    );
  }

  @override
  $RecentMovieEntriesTable createAlias(String alias) {
    return $RecentMovieEntriesTable(attachedDatabase, alias);
  }
}

class RecentMovieEntry extends DataClass
    implements Insertable<RecentMovieEntry> {
  final int movieId;
  final DateTime viewedAt;
  const RecentMovieEntry({required this.movieId, required this.viewedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['movie_id'] = Variable<int>(movieId);
    map['viewed_at'] = Variable<DateTime>(viewedAt);
    return map;
  }

  RecentMovieEntriesCompanion toCompanion(bool nullToAbsent) {
    return RecentMovieEntriesCompanion(
      movieId: Value(movieId),
      viewedAt: Value(viewedAt),
    );
  }

  factory RecentMovieEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentMovieEntry(
      movieId: serializer.fromJson<int>(json['movieId']),
      viewedAt: serializer.fromJson<DateTime>(json['viewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'movieId': serializer.toJson<int>(movieId),
      'viewedAt': serializer.toJson<DateTime>(viewedAt),
    };
  }

  RecentMovieEntry copyWith({int? movieId, DateTime? viewedAt}) =>
      RecentMovieEntry(
        movieId: movieId ?? this.movieId,
        viewedAt: viewedAt ?? this.viewedAt,
      );
  RecentMovieEntry copyWithCompanion(RecentMovieEntriesCompanion data) {
    return RecentMovieEntry(
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentMovieEntry(')
          ..write('movieId: $movieId, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(movieId, viewedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentMovieEntry &&
          other.movieId == this.movieId &&
          other.viewedAt == this.viewedAt);
}

class RecentMovieEntriesCompanion extends UpdateCompanion<RecentMovieEntry> {
  final Value<int> movieId;
  final Value<DateTime> viewedAt;
  const RecentMovieEntriesCompanion({
    this.movieId = const Value.absent(),
    this.viewedAt = const Value.absent(),
  });
  RecentMovieEntriesCompanion.insert({
    this.movieId = const Value.absent(),
    required DateTime viewedAt,
  }) : viewedAt = Value(viewedAt);
  static Insertable<RecentMovieEntry> custom({
    Expression<int>? movieId,
    Expression<DateTime>? viewedAt,
  }) {
    return RawValuesInsertable({
      if (movieId != null) 'movie_id': movieId,
      if (viewedAt != null) 'viewed_at': viewedAt,
    });
  }

  RecentMovieEntriesCompanion copyWith(
      {Value<int>? movieId, Value<DateTime>? viewedAt}) {
    return RecentMovieEntriesCompanion(
      movieId: movieId ?? this.movieId,
      viewedAt: viewedAt ?? this.viewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<DateTime>(viewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentMovieEntriesCompanion(')
          ..write('movieId: $movieId, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedMoviesTable cachedMovies = $CachedMoviesTable(this);
  late final $CachedSearchResultsTable cachedSearchResults =
      $CachedSearchResultsTable(this);
  late final $SearchHistoryEntriesTable searchHistoryEntries =
      $SearchHistoryEntriesTable(this);
  late final $RecentMovieEntriesTable recentMovieEntries =
      $RecentMovieEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        cachedMovies,
        cachedSearchResults,
        searchHistoryEntries,
        recentMovieEntries
      ];
}

typedef $$CachedMoviesTableCreateCompanionBuilder = CachedMoviesCompanion
    Function({
  Value<int> movieId,
  required String title,
  Value<String?> overview,
  Value<String?> posterPath,
  Value<String?> releaseDate,
  Value<double> voteAverage,
  Value<String> genreIds,
  required DateTime cachedAt,
});
typedef $$CachedMoviesTableUpdateCompanionBuilder = CachedMoviesCompanion
    Function({
  Value<int> movieId,
  Value<String> title,
  Value<String?> overview,
  Value<String?> posterPath,
  Value<String?> releaseDate,
  Value<double> voteAverage,
  Value<String> genreIds,
  Value<DateTime> cachedAt,
});

class $$CachedMoviesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedMoviesTable> {
  $$CachedMoviesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get movieId => $composableBuilder(
      column: $table.movieId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get overview => $composableBuilder(
      column: $table.overview, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genreIds => $composableBuilder(
      column: $table.genreIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedMoviesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedMoviesTable> {
  $$CachedMoviesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get movieId => $composableBuilder(
      column: $table.movieId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get overview => $composableBuilder(
      column: $table.overview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genreIds => $composableBuilder(
      column: $table.genreIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedMoviesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedMoviesTable> {
  $$CachedMoviesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get movieId =>
      $composableBuilder(column: $table.movieId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => column);

  GeneratedColumn<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => column);

  GeneratedColumn<String> get genreIds =>
      $composableBuilder(column: $table.genreIds, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedMoviesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedMoviesTable,
    CachedMovy,
    $$CachedMoviesTableFilterComposer,
    $$CachedMoviesTableOrderingComposer,
    $$CachedMoviesTableAnnotationComposer,
    $$CachedMoviesTableCreateCompanionBuilder,
    $$CachedMoviesTableUpdateCompanionBuilder,
    (CachedMovy, BaseReferences<_$AppDatabase, $CachedMoviesTable, CachedMovy>),
    CachedMovy,
    PrefetchHooks Function()> {
  $$CachedMoviesTableTableManager(_$AppDatabase db, $CachedMoviesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMoviesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMoviesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMoviesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> movieId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> overview = const Value.absent(),
            Value<String?> posterPath = const Value.absent(),
            Value<String?> releaseDate = const Value.absent(),
            Value<double> voteAverage = const Value.absent(),
            Value<String> genreIds = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
          }) =>
              CachedMoviesCompanion(
            movieId: movieId,
            title: title,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            genreIds: genreIds,
            cachedAt: cachedAt,
          ),
          createCompanionCallback: ({
            Value<int> movieId = const Value.absent(),
            required String title,
            Value<String?> overview = const Value.absent(),
            Value<String?> posterPath = const Value.absent(),
            Value<String?> releaseDate = const Value.absent(),
            Value<double> voteAverage = const Value.absent(),
            Value<String> genreIds = const Value.absent(),
            required DateTime cachedAt,
          }) =>
              CachedMoviesCompanion.insert(
            movieId: movieId,
            title: title,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            genreIds: genreIds,
            cachedAt: cachedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedMoviesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedMoviesTable,
    CachedMovy,
    $$CachedMoviesTableFilterComposer,
    $$CachedMoviesTableOrderingComposer,
    $$CachedMoviesTableAnnotationComposer,
    $$CachedMoviesTableCreateCompanionBuilder,
    $$CachedMoviesTableUpdateCompanionBuilder,
    (CachedMovy, BaseReferences<_$AppDatabase, $CachedMoviesTable, CachedMovy>),
    CachedMovy,
    PrefetchHooks Function()>;
typedef $$CachedSearchResultsTableCreateCompanionBuilder
    = CachedSearchResultsCompanion Function({
  required String query,
  required int movieId,
  required int position,
  required DateTime cachedAt,
  Value<int> rowid,
});
typedef $$CachedSearchResultsTableUpdateCompanionBuilder
    = CachedSearchResultsCompanion Function({
  Value<String> query,
  Value<int> movieId,
  Value<int> position,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CachedSearchResultsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedSearchResultsTable> {
  $$CachedSearchResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get query => $composableBuilder(
      column: $table.query, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get movieId => $composableBuilder(
      column: $table.movieId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedSearchResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedSearchResultsTable> {
  $$CachedSearchResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get query => $composableBuilder(
      column: $table.query, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get movieId => $composableBuilder(
      column: $table.movieId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedSearchResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedSearchResultsTable> {
  $$CachedSearchResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  GeneratedColumn<int> get movieId =>
      $composableBuilder(column: $table.movieId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedSearchResultsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedSearchResultsTable,
    CachedSearchResult,
    $$CachedSearchResultsTableFilterComposer,
    $$CachedSearchResultsTableOrderingComposer,
    $$CachedSearchResultsTableAnnotationComposer,
    $$CachedSearchResultsTableCreateCompanionBuilder,
    $$CachedSearchResultsTableUpdateCompanionBuilder,
    (
      CachedSearchResult,
      BaseReferences<_$AppDatabase, $CachedSearchResultsTable,
          CachedSearchResult>
    ),
    CachedSearchResult,
    PrefetchHooks Function()> {
  $$CachedSearchResultsTableTableManager(
      _$AppDatabase db, $CachedSearchResultsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedSearchResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedSearchResultsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedSearchResultsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> query = const Value.absent(),
            Value<int> movieId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedSearchResultsCompanion(
            query: query,
            movieId: movieId,
            position: position,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String query,
            required int movieId,
            required int position,
            required DateTime cachedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedSearchResultsCompanion.insert(
            query: query,
            movieId: movieId,
            position: position,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedSearchResultsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedSearchResultsTable,
    CachedSearchResult,
    $$CachedSearchResultsTableFilterComposer,
    $$CachedSearchResultsTableOrderingComposer,
    $$CachedSearchResultsTableAnnotationComposer,
    $$CachedSearchResultsTableCreateCompanionBuilder,
    $$CachedSearchResultsTableUpdateCompanionBuilder,
    (
      CachedSearchResult,
      BaseReferences<_$AppDatabase, $CachedSearchResultsTable,
          CachedSearchResult>
    ),
    CachedSearchResult,
    PrefetchHooks Function()>;
typedef $$SearchHistoryEntriesTableCreateCompanionBuilder
    = SearchHistoryEntriesCompanion Function({
  required String query,
  required DateTime searchedAt,
  Value<int> rowid,
});
typedef $$SearchHistoryEntriesTableUpdateCompanionBuilder
    = SearchHistoryEntriesCompanion Function({
  Value<String> query,
  Value<DateTime> searchedAt,
  Value<int> rowid,
});

class $$SearchHistoryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SearchHistoryEntriesTable> {
  $$SearchHistoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get query => $composableBuilder(
      column: $table.query, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get searchedAt => $composableBuilder(
      column: $table.searchedAt, builder: (column) => ColumnFilters(column));
}

class $$SearchHistoryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchHistoryEntriesTable> {
  $$SearchHistoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get query => $composableBuilder(
      column: $table.query, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get searchedAt => $composableBuilder(
      column: $table.searchedAt, builder: (column) => ColumnOrderings(column));
}

class $$SearchHistoryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchHistoryEntriesTable> {
  $$SearchHistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  GeneratedColumn<DateTime> get searchedAt => $composableBuilder(
      column: $table.searchedAt, builder: (column) => column);
}

class $$SearchHistoryEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SearchHistoryEntriesTable,
    SearchHistoryEntry,
    $$SearchHistoryEntriesTableFilterComposer,
    $$SearchHistoryEntriesTableOrderingComposer,
    $$SearchHistoryEntriesTableAnnotationComposer,
    $$SearchHistoryEntriesTableCreateCompanionBuilder,
    $$SearchHistoryEntriesTableUpdateCompanionBuilder,
    (
      SearchHistoryEntry,
      BaseReferences<_$AppDatabase, $SearchHistoryEntriesTable,
          SearchHistoryEntry>
    ),
    SearchHistoryEntry,
    PrefetchHooks Function()> {
  $$SearchHistoryEntriesTableTableManager(
      _$AppDatabase db, $SearchHistoryEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoryEntriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchHistoryEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> query = const Value.absent(),
            Value<DateTime> searchedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SearchHistoryEntriesCompanion(
            query: query,
            searchedAt: searchedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String query,
            required DateTime searchedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SearchHistoryEntriesCompanion.insert(
            query: query,
            searchedAt: searchedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SearchHistoryEntriesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SearchHistoryEntriesTable,
        SearchHistoryEntry,
        $$SearchHistoryEntriesTableFilterComposer,
        $$SearchHistoryEntriesTableOrderingComposer,
        $$SearchHistoryEntriesTableAnnotationComposer,
        $$SearchHistoryEntriesTableCreateCompanionBuilder,
        $$SearchHistoryEntriesTableUpdateCompanionBuilder,
        (
          SearchHistoryEntry,
          BaseReferences<_$AppDatabase, $SearchHistoryEntriesTable,
              SearchHistoryEntry>
        ),
        SearchHistoryEntry,
        PrefetchHooks Function()>;
typedef $$RecentMovieEntriesTableCreateCompanionBuilder
    = RecentMovieEntriesCompanion Function({
  Value<int> movieId,
  required DateTime viewedAt,
});
typedef $$RecentMovieEntriesTableUpdateCompanionBuilder
    = RecentMovieEntriesCompanion Function({
  Value<int> movieId,
  Value<DateTime> viewedAt,
});

class $$RecentMovieEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $RecentMovieEntriesTable> {
  $$RecentMovieEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get movieId => $composableBuilder(
      column: $table.movieId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get viewedAt => $composableBuilder(
      column: $table.viewedAt, builder: (column) => ColumnFilters(column));
}

class $$RecentMovieEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentMovieEntriesTable> {
  $$RecentMovieEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get movieId => $composableBuilder(
      column: $table.movieId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get viewedAt => $composableBuilder(
      column: $table.viewedAt, builder: (column) => ColumnOrderings(column));
}

class $$RecentMovieEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentMovieEntriesTable> {
  $$RecentMovieEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get movieId =>
      $composableBuilder(column: $table.movieId, builder: (column) => column);

  GeneratedColumn<DateTime> get viewedAt =>
      $composableBuilder(column: $table.viewedAt, builder: (column) => column);
}

class $$RecentMovieEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecentMovieEntriesTable,
    RecentMovieEntry,
    $$RecentMovieEntriesTableFilterComposer,
    $$RecentMovieEntriesTableOrderingComposer,
    $$RecentMovieEntriesTableAnnotationComposer,
    $$RecentMovieEntriesTableCreateCompanionBuilder,
    $$RecentMovieEntriesTableUpdateCompanionBuilder,
    (
      RecentMovieEntry,
      BaseReferences<_$AppDatabase, $RecentMovieEntriesTable, RecentMovieEntry>
    ),
    RecentMovieEntry,
    PrefetchHooks Function()> {
  $$RecentMovieEntriesTableTableManager(
      _$AppDatabase db, $RecentMovieEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentMovieEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentMovieEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentMovieEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> movieId = const Value.absent(),
            Value<DateTime> viewedAt = const Value.absent(),
          }) =>
              RecentMovieEntriesCompanion(
            movieId: movieId,
            viewedAt: viewedAt,
          ),
          createCompanionCallback: ({
            Value<int> movieId = const Value.absent(),
            required DateTime viewedAt,
          }) =>
              RecentMovieEntriesCompanion.insert(
            movieId: movieId,
            viewedAt: viewedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecentMovieEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecentMovieEntriesTable,
    RecentMovieEntry,
    $$RecentMovieEntriesTableFilterComposer,
    $$RecentMovieEntriesTableOrderingComposer,
    $$RecentMovieEntriesTableAnnotationComposer,
    $$RecentMovieEntriesTableCreateCompanionBuilder,
    $$RecentMovieEntriesTableUpdateCompanionBuilder,
    (
      RecentMovieEntry,
      BaseReferences<_$AppDatabase, $RecentMovieEntriesTable, RecentMovieEntry>
    ),
    RecentMovieEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedMoviesTableTableManager get cachedMovies =>
      $$CachedMoviesTableTableManager(_db, _db.cachedMovies);
  $$CachedSearchResultsTableTableManager get cachedSearchResults =>
      $$CachedSearchResultsTableTableManager(_db, _db.cachedSearchResults);
  $$SearchHistoryEntriesTableTableManager get searchHistoryEntries =>
      $$SearchHistoryEntriesTableTableManager(_db, _db.searchHistoryEntries);
  $$RecentMovieEntriesTableTableManager get recentMovieEntries =>
      $$RecentMovieEntriesTableTableManager(_db, _db.recentMovieEntries);
}
