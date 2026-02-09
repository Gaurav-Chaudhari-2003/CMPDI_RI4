import 'package:flutter/material.dart';

const primaryColor = Color(0xFF005540); // Dark green from the image
const secondaryColor = Color(0xFF005540); // Same as primary
const accentColor = Color(0xFF005540);
const backgroundColor = Color(0xFFFAFAFA); // Light background
const surfaceColor = Colors.white;
const textColor = Color(0xFF333333);
const lightTextColor = Colors.black54;

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: secondaryColor,
    background: backgroundColor,
    surface: surfaceColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: textColor,
    onSurface: textColor,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColor, // App bar background is light
    foregroundColor: textColor, // App bar icons and title are dark
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: textColor,
    ),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: textColor),
    titleLarge: TextStyle(fontWeight: FontWeight.w600, color: textColor),
    titleMedium: TextStyle(color: textColor),
    bodyMedium: TextStyle(color: lightTextColor),
    labelLarge: TextStyle(fontWeight: FontWeight.bold),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: const BorderSide(color: Color(0xFFDDDDDD)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: primaryColor, width: 1.5),
    ),
    labelStyle: const TextStyle(color: lightTextColor),
    prefixIconColor: lightTextColor,
  ),
  cardTheme: CardTheme(
    elevation: 0,
    color: surfaceColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.grey.shade300),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey.shade500,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFFE0F2F1),
    labelStyle: TextStyle(color: primaryColor.withOpacity(0.9)),
    secondaryLabelStyle: TextStyle(color: primaryColor.withOpacity(0.9)),
    selectedColor: primaryColor,
    disabledColor: Colors.grey,
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
  ),
);
