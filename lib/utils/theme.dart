import 'package:flutter/material.dart';

class AppTheme {
  static final colors = AppColors();
  static final src = AppSrc();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(primaryColor: const Color(0xFF126F63));
  }
}

class AppColors {
  final primary = const Color(0xFF126F63);
  final primaryFontColor = const Color(0xFF202020);
  final secondaryFontColor = const Color(0xFFFFFCF1);
  final darkFontColor = const Color(0xFF263238);
  final notWhite = const Color.fromARGB(255, 235, 235, 235);
}

class AppSrc {}
