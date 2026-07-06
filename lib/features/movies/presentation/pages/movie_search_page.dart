import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../l10n/generated/app_localizations.dart';
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

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: context.read<MovieSearchBloc>().state.query,
    );
    context.read<MovieSearchBloc>().add(const MovieSearchStarted());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                  if (state.movies.isEmpty) {
                    return Center(
                      child: Text(l10n.noResults, style: AppTextStyles.body),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return MovieListItem(
                        movie: movie,
                        onTap: () {
                          context.read<MovieSearchBloc>().add(
                                MovieViewed(movie),
                              );
                        },
                      );
                    },
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
    if (history.isEmpty && recentlyViewed.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        if (history.isNotEmpty) ...[
          Text('История поиска', style: AppTextStyles.heading2),
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
          Text('Недавно просмотренные', style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          ...recentlyViewed.map((movie) => MovieListItem(movie: movie)),
        ],
      ],
    );
  }
}
