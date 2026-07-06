// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CineVault';

  @override
  String get searchHint => 'Movie title...';

  @override
  String get searchTitle => 'Search Movies';

  @override
  String get noResults => 'No results found';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get addToWatchlist => 'Add to watchlist';

  @override
  String releaseDateLabel(String date) {
    return 'Release date: $date';
  }

  @override
  String get searchNav => 'Search';

  @override
  String get watchlistNav => 'My list';

  @override
  String get settingsNav => 'Settings';

  @override
  String get searchHistoryTitle => 'Search history';

  @override
  String get recentlyViewedTitle => 'Recently viewed';

  @override
  String get loadMoreError => 'Could not load more movies';

  @override
  String get watchlistTitle => 'My list';

  @override
  String get watchlistEmpty => 'Your list is empty. Add movies from search.';

  @override
  String get ratingLabel => 'Rating:';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileJoined => 'Joined';

  @override
  String get profileFavorites => 'Favorites';

  @override
  String get profileViewed => 'Viewed';

  @override
  String get profileWatched => 'Watched';

  @override
  String get profileUnknown => 'Unknown';

  @override
  String get profileUserFallback => 'User';

  @override
  String get preferencesTitle => 'Preferences';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageKazakh => 'Kazakh';

  @override
  String get languageEnglish => 'English';

  @override
  String get darkThemeTitle => 'Dark theme';

  @override
  String get signOut => 'Sign out';

  @override
  String get descriptionTitle => 'Description';

  @override
  String get descriptionEmpty => 'No description available.';

  @override
  String get statusTitle => 'Status';

  @override
  String get statusWatched => 'Watched';

  @override
  String get statusWatching => 'Watching';

  @override
  String get statusPlanToWatch => 'Plan to Watch';

  @override
  String get statusDropped => 'Dropped';

  @override
  String get myRatingTitle => 'My rating';

  @override
  String get notesTitle => 'Notes';

  @override
  String get notesHint => 'Very nice ending. Rewatch later.';

  @override
  String get filtersTitle => 'Genres';

  @override
  String get sortByTitle => 'Sort by';

  @override
  String get sortRating => 'Rating';

  @override
  String get sortReleaseDate => 'Release Date';

  @override
  String get sortPopularity => 'Popularity';

  @override
  String get sortAz => 'A-Z';

  @override
  String get listWantToWatch => 'Want to Watch';

  @override
  String get listWatched => 'Watched';

  @override
  String get listDropped => 'Dropped';

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get statsMoviesWatched => 'Movies watched';

  @override
  String get statsFavorites => 'Favorites';

  @override
  String get statsSearches => 'Searches';

  @override
  String get statsAverageRating => 'Average rating';
}
