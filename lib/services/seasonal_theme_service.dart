import 'package:flutter/material.dart';

enum SeasonTheme { standard, festiveHoliday, summerBreak, backToSchool }

class SeasonalThemeService {
  /// Determine active season theme based on current date
  SeasonTheme getCurrentSeasonTheme() {
    final now = DateTime.now();
    // Festive Season (e.g., December)
    if (now.month == 12) {
      return SeasonTheme.festiveHoliday;
    }
    // Back to School (e.g., September/August)
    if (now.month == 8 || now.month == 9) {
      return SeasonTheme.backToSchool;
    }
    return SeasonTheme.standard;
  }

  /// Fetch theme colors and UI properties based on active season
  ThemeData getThemeData(SeasonTheme theme) {
    switch (theme) {
      case SeasonTheme.festiveHoliday:
        return ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          cardColor: const Color(0xFF1E293B),
        );
      case SeasonTheme.backToSchool:
        return ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          cardColor: const Color(0xFF1E293B),
        );
      case SeasonTheme.standard:
      default:
        return ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          cardColor: const Color(0xFF1E293B),
        );
    }
  }
}
