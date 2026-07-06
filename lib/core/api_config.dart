/// Конфигурация для доступа к TMDB API.
///
/// Ключ НЕ хранится в коде — он передаётся при запуске/сборке через
/// --dart-define, поэтому не попадает в git и не виден в репозитории.
///
/// Как запускать проект:
///   flutter run --dart-define=TMDB_API_KEY=твой_ключ_здесь
///
/// Как собирать релиз:
///   flutter build apk --dart-define=TMDB_API_KEY=твой_ключ_здесь
///
/// Чтобы не вводить ключ каждый раз вручную, создай файл
/// `run_dev.sh` (и добавь его в .gitignore!) со следующим содержимым:
///
///   #!/bin/bash
///   flutter run --dart-define=TMDB_API_KEY=твой_ключ_здесь
///
/// и запускай проект через `sh run_dev.sh`.
class ApiConfig {
  static const String tmdbApiKey = String.fromEnvironment(
    'TMDB_API_KEY',
    defaultValue: '',
  );

  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  /// Собирает полный URL постера из relative path, который приходит из API
  /// (например "/abc123.jpg" -> полный URL картинки)
  static String posterUrl(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) return '';
    return '$tmdbImageBaseUrl$posterPath';
  }
}
