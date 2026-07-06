import 'package:flutter/material.dart';

/// Все цвета приложения собраны здесь.
/// Никогда не пиши Color(0xFF...) напрямую в виджетах —
/// добавляй цвет сюда и используй AppColors.xxx
class AppColors {
  AppColors._(); // приватный конструктор — этот класс нельзя создать, только использовать статически

  // Основная палитра
  static const Color primary = Color(0xFF0D253F);
  static const Color secondary = Color(0xFF01B4E4);
  static const Color accent = Color(0xFF90CEA1);

  // Фон
  static const Color background = Color(0xFFF5F5F7);
  static const Color surface = Colors.white;

  // Текст
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6E6E6E);
  static const Color textOnPrimary = Colors.white;

  // Статусы
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFA000);

  // Рейтинг фильмов (звёзды)
  static const Color ratingGold = Color(0xFFF5C518);
}
