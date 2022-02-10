library app_theme;

import 'package:flutter/material.dart';

part 'themes/slider_theme.dart';

class AppTheme {
  static const blueColor = Color(0xFF00A8ED);
  static const pinkColor = Color(0xFFE3005A);

  static ThemeData get lightTheme => ThemeData(
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        primaryColor: pinkColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: blueColor,
        ),
        fontFamily: 'Segoe',
        scaffoldBackgroundColor: const Color(0xFFF9F3F0),
        sliderTheme: _sliderTheme,
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(
            Colors.white,
          ),
          fillColor: MaterialStateProperty.all(
            blueColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              3,
            ),
          ),
          splashRadius: 0,
        ),
      );
}
