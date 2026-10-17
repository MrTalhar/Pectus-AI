import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0D0D0F),
    primaryColor: const Color(0xFF4DD0E1),
    splashColor: const Color(0xFF4DD0E1).withAlpha(40),
    highlightColor: const Color(0xFF4DD0E1).withAlpha(20),
    hoverColor: const Color(0xFF4DD0E1).withAlpha(10),
    dividerColor: const Color(0xFF2A2A40),
    shadowColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4DD0E1),
      secondary: Color(0xFF80DEEA),
      surface: Color(0xFF1A1A2E),
      onPrimary: Color(0xFF0D0D0F),
      onSurface: Color(0xFFFFFFFF),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFF5F5F5)),
      bodyMedium: TextStyle(color: Color(0xFFF5F5F5)),
      labelLarge: TextStyle(color: Color(0xFF8E8E93)),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1A1A2E),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0D0D0F),
      elevation: 0,
      centerTitle: true,
      foregroundColor: Color(0xFFF5F5F5),
      surfaceTintColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF0D0D0F),
      selectedItemColor: Color(0xFF4DD0E1),
      unselectedItemColor: Color(0xFF5A5A5E),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: const Color(0xFF4DD0E1).withAlpha(40),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: Color(0xFF4DD0E1));
        }
        return const TextStyle(color: Color(0xFF5A5A5E));
      }),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(const Color(0xFF4DD0E1).withAlpha(30)),
      ),
    ),
    useMaterial3: true,
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5F5F7),
    primaryColor: const Color(0xFF00ACC1),
    splashColor: const Color(0xFF00ACC1).withAlpha(40),
    highlightColor: const Color(0xFF00ACC1).withAlpha(20),
    hoverColor: const Color(0xFF00ACC1).withAlpha(10),
    dividerColor: const Color(0xFFE5E5EA),
    shadowColor: Colors.black.withAlpha(40),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF00ACC1),
      secondary: Color(0xFF4DD0E1),
      surface: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1A1A1A),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1A1A1A)),
      bodyMedium: TextStyle(color: Color(0xFF1A1A1A)),
      labelLarge: TextStyle(color: Color(0xFF6E6E73)),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFFFFFFFF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF5F5F7),
      elevation: 0,
      centerTitle: true,
      foregroundColor: Color(0xFF1A1A1A),
      surfaceTintColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      selectedItemColor: Color(0xFF00ACC1),
      unselectedItemColor: Color(0xFF8E8E93),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: const Color(0xFF00ACC1).withAlpha(40),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: Color(0xFF00ACC1));
        }
        return const TextStyle(color: Color(0xFF8E8E93));
      }),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(const Color(0xFF00ACC1).withAlpha(30)),
      ),
    ),
    useMaterial3: true,
  );
}
