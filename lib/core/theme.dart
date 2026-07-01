import 'package:flutter/material.dart';

class QawwatTheme {
  static const Color primary = Color(0xFFC84B2F);
  static const Color primaryLight = Color(0xFFFFF1EC);
  static const Color primaryDark = Color(0xFF993C1D);
  static const Color amber = Color(0xFFFFF8E8);
  static const Color amberBorder = Color(0xFFFAC775);
  static const Color green = Color(0xFFEAF5F0);
  static const Color greenText = Color(0xFF085041);
  static const Color purple = Color(0xFF3C3489);
  static const Color purpleLight = Color(0xFFEEEDFE);
  static const Color dishBg = Color(0xFFF5C4A1);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    fontFamily: 'Tajawal',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F6F3),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFEAE8E4), width: 0.5),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primary,
      unselectedItemColor: Color(0xFFAAAAAA),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 10, fontFamily: 'Tajawal'),
      unselectedLabelStyle: TextStyle(fontSize: 10, fontFamily: 'Tajawal'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.w700, fontSize: 15),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );
}
