import 'package:flutter/material.dart';

class AppTheme {
  static final colors = AppColors();
  static final src = AppSrc();
  static final style = AppStyle();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(primaryColor: const Color(0xFFACBD86));
  }
}

class AppColors {
  // final primary = const Color(0xFF126F63);
  final primary = const Color(0xFFACBD86);
  final primaryFontColor = const Color(0xFF202020);
  final secondaryFontColor = const Color(0xFFFFFCF1);
  final darkFontColor = const Color(0xFF263238);
  final notWhite = const Color.fromARGB(255, 235, 235, 235);
  final infoFontColor = Color.fromARGB(255, 113, 113, 113);
  final subInfoFontColor = Color.fromARGB(255, 152, 152, 152);
  // final linearColors = LinearGradient(
  //   transform: GradientRotation(270),
  //   colors: [
  //     Color.fromARGB(255, 255, 255, 248),
  //     AppTheme.colors.secondaryFontColor
  //   ],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  // );
}

class AppStyle {
  final noButtonElevation = MaterialStateProperty.resolveWith<double>(
    // As you said you dont need elevation. I'm returning 0 in both case
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return 0;
      }
      return 0; // Defer to the widget's default.
    },
  );

  final primaryFontStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: AppTheme.colors.infoFontColor);
  final secondaryFontStyle = TextStyle(
      overflow: TextOverflow.fade,
      color: AppTheme.colors.subInfoFontColor,
      fontSize: 12);
}

class AppSrc {}
