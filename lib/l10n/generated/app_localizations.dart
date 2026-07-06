import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru')
  ];

  /// Название приложения
  ///
  /// In ru, this message translates to:
  /// **'CineVault'**
  String get appTitle;

  /// Плейсхолдер в поле поиска
  ///
  /// In ru, this message translates to:
  /// **'Название фильма...'**
  String get searchHint;

  /// Заголовок экрана поиска
  ///
  /// In ru, this message translates to:
  /// **'Поиск фильмов'**
  String get searchTitle;

  /// Сообщение при пустом результате поиска
  ///
  /// In ru, this message translates to:
  /// **'Ничего не найдено'**
  String get noResults;

  /// Общее сообщение об ошибке
  ///
  /// In ru, this message translates to:
  /// **'Что-то пошло не так. Попробуйте ещё раз.'**
  String get errorGeneric;

  /// Кнопка добавления фильма в watchlist
  ///
  /// In ru, this message translates to:
  /// **'Добавить в список'**
  String get addToWatchlist;

  /// Дата выхода фильма
  ///
  /// In ru, this message translates to:
  /// **'Дата выхода: {date}'**
  String releaseDateLabel(String date);

  /// No description provided for @searchNav.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get searchNav;

  /// No description provided for @watchlistNav.
  ///
  /// In ru, this message translates to:
  /// **'Мой список'**
  String get watchlistNav;

  /// No description provided for @settingsNav.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsNav;

  /// No description provided for @searchHistoryTitle.
  ///
  /// In ru, this message translates to:
  /// **'История поиска'**
  String get searchHistoryTitle;

  /// No description provided for @recentlyViewedTitle.
  ///
  /// In ru, this message translates to:
  /// **'Недавно просмотренные'**
  String get recentlyViewedTitle;

  /// No description provided for @loadMoreError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить ещё фильмы'**
  String get loadMoreError;

  /// No description provided for @watchlistTitle.
  ///
  /// In ru, this message translates to:
  /// **'Мой список'**
  String get watchlistTitle;

  /// No description provided for @watchlistEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Список пуст. Добавь фильмы через поиск!'**
  String get watchlistEmpty;

  /// No description provided for @ratingLabel.
  ///
  /// In ru, this message translates to:
  /// **'Рейтинг:'**
  String get ratingLabel;

  /// No description provided for @settingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsTitle;

  /// No description provided for @profileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profileTitle;

  /// No description provided for @profileEmail.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profileJoined.
  ///
  /// In ru, this message translates to:
  /// **'Дата регистрации'**
  String get profileJoined;

  /// No description provided for @profileFavorites.
  ///
  /// In ru, this message translates to:
  /// **'Избранное'**
  String get profileFavorites;

  /// No description provided for @profileViewed.
  ///
  /// In ru, this message translates to:
  /// **'Просмотрено'**
  String get profileViewed;

  /// No description provided for @profileWatched.
  ///
  /// In ru, this message translates to:
  /// **'Просмотренные'**
  String get profileWatched;

  /// No description provided for @profileUnknown.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестно'**
  String get profileUnknown;

  /// No description provided for @profileUserFallback.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь'**
  String get profileUserFallback;

  /// No description provided for @preferencesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Предпочтения'**
  String get preferencesTitle;

  /// No description provided for @languageTitle.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get languageTitle;

  /// No description provided for @languageRussian.
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get languageRussian;

  /// No description provided for @languageKazakh.
  ///
  /// In ru, this message translates to:
  /// **'Казахский'**
  String get languageKazakh;

  /// No description provided for @languageEnglish.
  ///
  /// In ru, this message translates to:
  /// **'Английский'**
  String get languageEnglish;

  /// No description provided for @darkThemeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная тема'**
  String get darkThemeTitle;

  /// No description provided for @signOut.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из аккаунта'**
  String get signOut;

  /// No description provided for @descriptionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get descriptionTitle;

  /// No description provided for @descriptionEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Описание недоступно.'**
  String get descriptionEmpty;

  /// No description provided for @statusTitle.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get statusTitle;

  /// No description provided for @statusWatched.
  ///
  /// In ru, this message translates to:
  /// **'Watched'**
  String get statusWatched;

  /// No description provided for @statusWatching.
  ///
  /// In ru, this message translates to:
  /// **'Watching'**
  String get statusWatching;

  /// No description provided for @statusPlanToWatch.
  ///
  /// In ru, this message translates to:
  /// **'Plan to Watch'**
  String get statusPlanToWatch;

  /// No description provided for @statusDropped.
  ///
  /// In ru, this message translates to:
  /// **'Dropped'**
  String get statusDropped;

  /// No description provided for @myRatingTitle.
  ///
  /// In ru, this message translates to:
  /// **'Моя оценка'**
  String get myRatingTitle;

  /// No description provided for @notesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Заметки'**
  String get notesTitle;

  /// No description provided for @notesHint.
  ///
  /// In ru, this message translates to:
  /// **'Очень понравился конец. Пересмотреть позже.'**
  String get notesHint;

  /// No description provided for @filtersTitle.
  ///
  /// In ru, this message translates to:
  /// **'Жанры'**
  String get filtersTitle;

  /// No description provided for @sortByTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сортировка'**
  String get sortByTitle;

  /// No description provided for @sortRating.
  ///
  /// In ru, this message translates to:
  /// **'Рейтинг'**
  String get sortRating;

  /// No description provided for @sortReleaseDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата выхода'**
  String get sortReleaseDate;

  /// No description provided for @sortPopularity.
  ///
  /// In ru, this message translates to:
  /// **'Популярность'**
  String get sortPopularity;

  /// No description provided for @sortAz.
  ///
  /// In ru, this message translates to:
  /// **'A-Z'**
  String get sortAz;

  /// No description provided for @listWantToWatch.
  ///
  /// In ru, this message translates to:
  /// **'Want to Watch'**
  String get listWantToWatch;

  /// No description provided for @listWatched.
  ///
  /// In ru, this message translates to:
  /// **'Watched'**
  String get listWatched;

  /// No description provided for @listDropped.
  ///
  /// In ru, this message translates to:
  /// **'Dropped'**
  String get listDropped;

  /// No description provided for @statisticsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Статистика'**
  String get statisticsTitle;

  /// No description provided for @statsMoviesWatched.
  ///
  /// In ru, this message translates to:
  /// **'Movies watched'**
  String get statsMoviesWatched;

  /// No description provided for @statsFavorites.
  ///
  /// In ru, this message translates to:
  /// **'Favorites'**
  String get statsFavorites;

  /// No description provided for @statsSearches.
  ///
  /// In ru, this message translates to:
  /// **'Searches'**
  String get statsSearches;

  /// No description provided for @statsAverageRating.
  ///
  /// In ru, this message translates to:
  /// **'Average rating'**
  String get statsAverageRating;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
