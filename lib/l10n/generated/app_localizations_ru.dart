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
}
