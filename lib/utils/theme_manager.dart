import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    primaryColor: const Color(0xFF4F46E5),
  );
}
