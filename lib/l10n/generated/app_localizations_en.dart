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
}
