// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'CineVault';

  @override
  String get searchHint => 'Название фильма...';

  @override
  String get searchTitle => 'Поиск фильмов';

  @override
  String get noResults => 'Ничего не найдено';

  @override
  String get errorGeneric => 'Что-то пошло не так. Попробуйте ещё раз.';

  @override
  String get addToWatchlist => 'Добавить в список';

  @override
  String releaseDateLabel(String date) {
    return 'Дата выхода: $date';
  }

  @override
  String get searchNav => 'Поиск';

  @override
  String get watchlistNav => 'Мой список';

  @override
  String get settingsNav => 'Настройки';

  @override
  String get searchHistoryTitle => 'История поиска';

  @override
  String get recentlyViewedTitle => 'Недавно просмотренные';

  @override
  String get loadMoreError => 'Не удалось загрузить ещё фильмы';

  @override
  String get watchlistTitle => 'Мой список';

  @override
  String get watchlistEmpty => 'Список пуст. Добавь фильмы через поиск!';

  @override
  String get ratingLabel => 'Рейтинг:';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileJoined => 'Дата регистрации';

  @override
  String get profileFavorites => 'Избранное';

  @override
  String get profileViewed => 'Просмотрено';

  @override
  String get profileWatched => 'Просмотренные';

  @override
  String get profileUnknown => 'Неизвестно';

  @override
  String get profileUserFallback => 'Пользователь';

  @override
  String get preferencesTitle => 'Предпочтения';

  @override
  String get languageTitle => 'Язык';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageKazakh => 'Казахский';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get darkThemeTitle => 'Тёмная тема';

  @override
  String get signOut => 'Выйти из аккаунта';

  @override
  String get descriptionTitle => 'Описание';

  @override
  String get descriptionEmpty => 'Описание недоступно.';

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
  String get myRatingTitle => 'Моя оценка';

  @override
  String get notesTitle => 'Заметки';

  @override
  String get notesHint => 'Очень понравился конец. Пересмотреть позже.';

  @override
  String get filtersTitle => 'Жанры';

  @override
  String get sortByTitle => 'Сортировка';

  @override
  String get sortRating => 'Рейтинг';

  @override
  String get sortReleaseDate => 'Дата выхода';

  @override
  String get sortPopularity => 'Популярность';

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
