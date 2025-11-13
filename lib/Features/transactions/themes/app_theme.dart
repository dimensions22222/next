// themes/app_theme.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF0D47A1);

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryBlue,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: _createMaterialColor(primaryBlue))
          .copyWith(secondary: primaryBlue),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0.5,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontWeight: FontWeight.w400),
        titleMedium: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  // helper to convert Color to MaterialColor
  static MaterialColor _createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch.map((k, v) => MapEntry(k ~/ 10, v)));
  }
}
