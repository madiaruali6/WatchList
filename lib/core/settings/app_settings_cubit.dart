import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsState extends Equatable {
  final Locale locale;
  final ThemeMode themeMode;

  const AppSettingsState({
    required this.locale,
    required this.themeMode,
  });

  bool get isDarkMode => themeMode == ThemeMode.dark;

  @override
  List<Object?> get props => [locale, themeMode];
}

class AppSettingsCubit extends Cubit<AppSettingsState> {
  static const _localeKey = 'settings_locale';
  static const _themeModeKey = 'settings_theme_mode';

  final SharedPreferences _preferences;

  AppSettingsCubit(this._preferences)
      : super(
          AppSettingsState(
            locale: Locale(_preferences.getString(_localeKey) ?? 'ru'),
            themeMode: _themeModeFromString(
              _preferences.getString(_themeModeKey),
            ),
          ),
        );

  Future<void> setLocale(Locale locale) async {
    await _preferences.setString(_localeKey, locale.languageCode);
    emit(AppSettingsState(locale: locale, themeMode: state.themeMode));
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _preferences.setString(_themeModeKey, themeMode.name);
    emit(AppSettingsState(locale: state.locale, themeMode: themeMode));
  }

  Future<void> setDarkMode(bool isDarkMode) {
    return setThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  static ThemeMode _themeModeFromString(String? value) {
    return value == ThemeMode.dark.name ? ThemeMode.dark : ThemeMode.light;
  }
}
