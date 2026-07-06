/// Конфигурация доступа к TMDB API.
///
/// Ключ передаётся через --dart-define, поэтому не хранится в коде
/// и не попадает в git.
///
/// Запуск:
///   flutter run --dart-define=TMDB_API_KEY=твой_ключ
///
/// Чтобы не вводить каждый раз — создай файл run_dev.sh (добавь его
/// в .gitignore!):
///   #!/bin/bash
///   flutter run --dart-define=TMDB_API_KEY=твой_ключ
class ApiConfig {
  ApiConfig._();

  static const String tmdbApiKey = String.fromEnvironment(
    'TMDB_API_KEY',
    defaultValue: '',
  );

  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static String posterUrl(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) return '';
    return '$tmdbImageBaseUrl$posterPath';
  }
}
