// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'CineVault';

  @override
  String get searchHint => 'Фильм атауы...';

  @override
  String get searchTitle => 'Фильмдерді іздеу';

  @override
  String get noResults => 'Нәтиже табылмады';

  @override
  String get errorGeneric => 'Бірдеңе дұрыс болмады. Қайталап көріңіз.';

  @override
  String get addToWatchlist => 'Тізімге қосу';

  @override
  String releaseDateLabel(String date) {
    return 'Шыққан күні: $date';
  }

  @override
  String get searchNav => 'Іздеу';

  @override
  String get watchlistNav => 'Менің тізімім';

  @override
  String get settingsNav => 'Баптаулар';

  @override
  String get searchHistoryTitle => 'Іздеу тарихы';

  @override
  String get recentlyViewedTitle => 'Жақында қаралғандар';

  @override
  String get loadMoreError => 'Қосымша фильмдерді жүктеу мүмкін болмады';

  @override
  String get watchlistTitle => 'Менің тізімім';

  @override
  String get watchlistEmpty => 'Тізім бос. Фильмдерді іздеу арқылы қосыңыз.';

  @override
  String get ratingLabel => 'Рейтинг:';

  @override
  String get settingsTitle => 'Баптаулар';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileJoined => 'Қосылған күні';

  @override
  String get profileFavorites => 'Таңдаулылар';

  @override
  String get profileViewed => 'Қаралған';

  @override
  String get profileWatched => 'Көрілген';

  @override
  String get profileUnknown => 'Белгісіз';

  @override
  String get profileUserFallback => 'Пайдаланушы';

  @override
  String get preferencesTitle => 'Параметрлер';

  @override
  String get languageTitle => 'Тіл';

  @override
  String get languageRussian => 'Орысша';

  @override
  String get languageKazakh => 'Қазақша';

  @override
  String get languageEnglish => 'Ағылшынша';

  @override
  String get darkThemeTitle => 'Қараңғы тақырып';

  @override
  String get signOut => 'Аккаунттан шығу';

  @override
  String get descriptionTitle => 'Сипаттама';

  @override
  String get descriptionEmpty => 'Сипаттама жоқ.';

  @override
  String get statusTitle => 'Статус';

  @override
  String get statusWatched => 'Watched';

  @override
  String get statusWatching => 'Watching';

  @override
  String get statusPlanToWatch => 'Plan to Watch';

  @override
  String get statusDropped => 'Dropped';

  @override
  String get myRatingTitle => 'Менің бағам';

  @override
  String get notesTitle => 'Жазбалар';

  @override
  String get notesHint => 'Соңы қатты ұнады. Кейін қайта көру.';

  @override
  String get filtersTitle => 'Жанрлар';

  @override
  String get sortByTitle => 'Сұрыптау';

  @override
  String get sortRating => 'Рейтинг';

  @override
  String get sortReleaseDate => 'Шыққан күні';

  @override
  String get sortPopularity => 'Танымалдық';

  @override
  String get sortAz => 'A-Z';

  @override
  String get listWantToWatch => 'Want to Watch';

  @override
  String get listWatched => 'Watched';

  @override
  String get listDropped => 'Dropped';

  @override
  String get statisticsTitle => 'Статистика';

  @override
  String get statsMoviesWatched => 'Movies watched';

  @override
  String get statsFavorites => 'Favorites';

  @override
  String get statsSearches => 'Searches';

  @override
  String get statsAverageRating => 'Average rating';
}
