import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../movies/data/datasources/user_movie_local_data_source.dart';
import '../../../movies/domain/entities/user_movie_entry.dart';
import '../../../movies/presentation/widgets/movie_list_item.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final _store = getIt<UserMovieLocalDataSource>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.watchlistTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.listWantToWatch),
              Tab(text: l10n.listWatched),
              Tab(text: l10n.listDropped),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _StatusMovieList(
              status: UserMovieStatus.wantToWatch,
              store: _store,
            ),
            _StatusMovieList(
              status: UserMovieStatus.watched,
              store: _store,
            ),
            _StatusMovieList(
              status: UserMovieStatus.dropped,
              store: _store,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusMovieList extends StatefulWidget {
  final UserMovieStatus status;
  final UserMovieLocalDataSource store;

  const _StatusMovieList({
    required this.status,
    required this.store,
  });

  @override
  State<_StatusMovieList> createState() => _StatusMovieListState();
}

class _StatusMovieListState extends State<_StatusMovieList> {
  late Future<List<UserMovieEntry>> _entriesFuture;

  @override
  void initState() {
    super.initState();
    _entriesFuture = widget.store.getEntriesByStatus(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<List<UserMovieEntry>>(
      future: _entriesFuture,
      builder: (context, snapshot) {
        final entries = snapshot.data ?? [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (entries.isEmpty) {
          return Center(child: Text(l10n.watchlistEmpty));
        }

        return ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return MovieListItem(
              movie: entry.movie,
              onTap: () async {
                await context.push(AppRoutes.movieDetails, extra: entry.movie);
                if (!mounted) return;
                setState(() {
                  _entriesFuture = widget.store.getEntriesByStatus(
                    widget.status,
                  );
                });
              },
            );
          },
        );
      },
    );
  }
}
