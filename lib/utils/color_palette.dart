import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'font_palette.dart';

class ColorPalette {
  static ThemeData get themeData => ThemeData(
      fontFamily: FontPalette.themeFont,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return ColorPalette.primaryColor;
              } else if (states.contains(MaterialState.disabled)) {
                return ColorPalette.primaryColor;
              }
              return ColorPalette.primaryColor;
            },
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
              statusBarBrightness:
                  Platform.isIOS ? Brightness.light : Brightness.dark)),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: ColorPalette.materialPrimary)
              .copyWith(background: Colors.white));

  static Color get primaryColor => const Color(0xFF076633);

  static Color get secondaryColor => const Color(0xFF212121);

  static const MaterialColor materialPrimary = MaterialColor(
    0xFFE50019,
    <int, Color>{
      50: Color(0xFF076633),
      100: Color(0xFF076633),
      200: Color(0xFF076633),
      300: Color(0xFF076633),
      400: Color(0xFF076633),
      500: Color(0xFF076633),
      600: Color(0xFF076633),
      700: Color(0xFF076633),
      800: Color(0xFF076633),
      900: Color(0xFF076633),
    },
  );
}
