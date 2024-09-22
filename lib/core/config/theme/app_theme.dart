import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final Color primaryLight;
  final Color primaryDark;

  AppTheme({
    this.primaryLight = const Color(0xFF668CFF),
    this.primaryDark = const Color(0xFF0033CC),
  });

  ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      actionIconTheme: ActionIconThemeData(
        drawerButtonIconBuilder: (context) =>
            Icon(size: 40, Icons.menu, color: colorScheme.onSurface),
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onPrimary,
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
    );
  }

  ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      primary: primaryLight,
      seedColor: primaryLight,
      brightness: Brightness.light,
      onSurface: Colors.black,
      surface: Colors.white,
    );
    return _buildTheme(colorScheme);
  }

  ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      primary: primaryDark,
      seedColor: primaryDark,
      brightness: Brightness.dark,
      onSurface: Colors.white,
      surface: Colors.black,
    );
    return _buildTheme(colorScheme);
  }

  AppTheme copyWith({
    Color? primaryColor,
    Color? primaryDark,
  }) =>
      AppTheme(
        primaryLight: primaryColor ?? this.primaryLight,
        primaryDark: primaryDark ?? this.primaryDark,
      );
}

extension CustomColorScheme on ColorScheme {
  Color get primaryLightest => const Color(0xFFE6F0FF);
  Color get primaryLighter => const Color(0xFF99B3FF);
  Color get primaryDarker => const Color(0xFF002699);
  Color get primaryDarkest => const Color(0xFF001A66);
}
