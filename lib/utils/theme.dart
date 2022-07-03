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
  final primaryShade = Color.fromARGB(255, 216, 231, 185);
  final primary = const Color(0xFF9FBC60);
  // final primary = const Color(0xFFACBD86);
  final primaryFontColor = const Color(0xFF202020);
  final secondaryFontColor = const Color(0xFFFFFCF1);
  final darkFontColor = const Color(0xFF263238);
  final notWhite = const Color.fromARGB(255, 235, 235, 235);
  final infoFontColor = Color.fromARGB(255, 113, 113, 113);
  final subInfoFontColor = Color.fromARGB(255, 152, 152, 152);
  final decorateColor = Color(0xFF16868D);
  final pink = Color(0xFFF7A4A4);
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

  final titleFontStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppTheme.colors.darkFontColor);
  final bodyFontStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppTheme.colors.infoFontColor);
  final primaryFontStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: AppTheme.colors.infoFontColor);
  final secondaryFontStyle = TextStyle(
      overflow: TextOverflow.fade,
      color: AppTheme.colors.subInfoFontColor,
      fontSize: 10);

  textFieldStyle({hinttext: String, prefixIcon: null}) {
    return InputDecoration(
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(fontSize: 12, height: 2),
        hintText: '${hinttext}',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: EdgeInsets.only(left: 10, right: 10),
        // suffixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white);
  }
}

class AppSrc {
  final String astroCat = 'assets/images/Catastronaut-cuate.png';
  final String dogImage = 'assets/images/shiba.png';
  final String catImage = 'assets/images/cat.png';
  final String sharkImage = 'assets/images/shark.png';
  final String profileImage =
      'https://i.pinimg.com/564x/a6/a5/9c/a6a59cf39b63d214cb7feab97b8c9a59.jpg';
  final empty =
      'https://img.freepik.com/free-vector/cautious-dog-concept-illustration_114360-5228.jpg?w=740&t=st=1651687836~exp=1651688436~hmac=0d43f76081c7d3dda56fe2cbe3e90995625001dd1cd4474469dd8896aa327c3a';
}
