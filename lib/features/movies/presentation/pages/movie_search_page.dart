import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/movie.dart';
import '../bloc/movie_search_bloc.dart';
import '../bloc/movie_search_event.dart';
import '../bloc/movie_search_state.dart';
import '../widgets/movie_list_item.dart';
import '../widgets/movie_search_shimmer.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  final Set<int> _selectedGenres = {};
  _MovieSortOption _sortOption = _MovieSortOption.rating;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: context.read<MovieSearchBloc>().state.query,
    );
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<MovieSearchBloc>().add(const MovieSearchStarted());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      context.read<MovieSearchBloc>().add(const SearchNextPageRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.searchTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                suffixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) {
                context.read<MovieSearchBloc>().add(SearchQueryChanged(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, state) {
                if (state is MovieSearchInitial) {
                  return _SearchOverview(
                    history: state.history,
                    recentlyViewed: state.recentlyViewed,
                    onQuerySelected: (query) {
                      _searchController.text = query;
                      context.read<MovieSearchBloc>().add(
                            SearchQueryChanged(query),
                          );
                    },
                  );
                }
                if (state is MovieSearchLoading) {
                  return const MovieSearchShimmer();
                }
                if (state is MovieSearchError) {
                  return Center(
                    child: Text(state.message, style: AppTextStyles.body),
                  );
                }
                if (state is MovieSearchLoaded) {
                  final visibleMovies = _applyFiltersAndSorting(state.movies);

                  if (state.movies.isEmpty) {
                    return Center(
                      child: Text(l10n.noResults, style: AppTextStyles.body),
                    );
                  }
                  return ListView(
                    controller: _scrollController,
                    children: [
                      _SearchControls(
                        selectedGenres: _selectedGenres,
                        sortOption: _sortOption,
                        onGenreToggled: (genreId) {
                          setState(() {
                            if (!_selectedGenres.add(genreId)) {
                              _selectedGenres.remove(genreId);
                            }
                          });
                        },
                        onSortChanged: (sortOption) {
                          setState(() => _sortOption = sortOption);
                        },
                      ),
                      if (visibleMovies.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            l10n.noResults,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body,
                          ),
                        ),
                      ...visibleMovies.map(
                        (movie) => MovieListItem(
                          movie: movie,
                          onTap: () {
                            context.read<MovieSearchBloc>().add(
                                  MovieViewed(movie),
                                );
                            context.push(AppRoutes.movieDetails, extra: movie);
                          },
                        ),
                      ),
                      if (state.loadMoreError != null)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            l10n.loadMoreError,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodySecondary,
                          ),
                        ),
                      if (state.isLoadingMore)
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Movie> _applyFiltersAndSorting(List<Movie> movies) {
    final filtered = _selectedGenres.isEmpty
        ? movies.toList()
        : movies
            .where(
              (movie) => movie.genreIds.any(_selectedGenres.contains),
            )
            .toList();

    switch (_sortOption) {
      case _MovieSortOption.rating:
        filtered.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
      case _MovieSortOption.releaseDate:
        filtered.sort(
          (a, b) => (b.releaseDate ?? '').compareTo(a.releaseDate ?? ''),
        );
      case _MovieSortOption.popularity:
        filtered.sort((a, b) => b.popularity.compareTo(a.popularity));
      case _MovieSortOption.az:
        filtered.sort((a, b) => a.title.compareTo(b.title));
    }

    return filtered;
  }
}

enum _MovieSortOption { rating, releaseDate, popularity, az }

class _SearchControls extends StatelessWidget {
  static const genres = {
    28: 'Action',
    35: 'Comedy',
    18: 'Drama',
    14: 'Fantasy',
  };

  final Set<int> selectedGenres;
  final _MovieSortOption sortOption;
  final ValueChanged<int> onGenreToggled;
  final ValueChanged<_MovieSortOption> onSortChanged;

  const _SearchControls({
    required this.selectedGenres,
    required this.sortOption,
    required this.onGenreToggled,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.filtersTitle,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: genres.entries.map((entry) {
              return FilterChip(
                label: Text(entry.value),
                selected: selectedGenres.contains(entry.key),
                onSelected: (_) => onGenreToggled(entry.key),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<_MovieSortOption>(
            initialValue: sortOption,
            decoration: InputDecoration(labelText: l10n.sortByTitle),
            items: [
              DropdownMenuItem(
                value: _MovieSortOption.rating,
                child: Text(l10n.sortRating),
              ),
              DropdownMenuItem(
                value: _MovieSortOption.releaseDate,
                child: Text(l10n.sortReleaseDate),
              ),
              DropdownMenuItem(
                value: _MovieSortOption.popularity,
                child: Text(l10n.sortPopularity),
              ),
              DropdownMenuItem(
                value: _MovieSortOption.az,
                child: Text(l10n.sortAz),
              ),
            ],
            onChanged: (value) {
              if (value != null) onSortChanged(value);
            },
          ),
        ],
      ),
    );
  }
}

class _SearchOverview extends StatelessWidget {
  final List<String> history;
  final List recentlyViewed;
  final ValueChanged<String> onQuerySelected;

  const _SearchOverview({
    required this.history,
    required this.recentlyViewed,
    required this.onQuerySelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (history.isEmpty && recentlyViewed.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        if (history.isNotEmpty) ...[
          Text(l10n.searchHistoryTitle, style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: history
                .map(
                  (query) => ActionChip(
                    label: Text(query),
                    onPressed: () => onQuerySelected(query),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
        ],
        if (recentlyViewed.isNotEmpty) ...[
          Text(l10n.recentlyViewedTitle, style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          ...recentlyViewed.map(
            (movie) => MovieListItem(
              movie: movie,
              onTap: () => context.push(AppRoutes.movieDetails, extra: movie),
            ),
          ),
        ],
      ],
    );
  }
}
