import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchOverview {
  final List<String> history;
  final List<Movie> recentlyViewed;

  const SearchOverview({
    required this.history,
    required this.recentlyViewed,
  });
}

class GetSearchOverviewUseCase {
  final MovieRepository repository;

  GetSearchOverviewUseCase(this.repository);

  Future<SearchOverview> call() async {
    final history = await repository.getSearchHistory();
    final recentlyViewed = await repository.getRecentlyViewed();

    return SearchOverview(
      history: history,
      recentlyViewed: recentlyViewed,
    );
  }
}
