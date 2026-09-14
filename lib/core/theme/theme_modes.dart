import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/theme/theme_extension.dart';

import 'package:movies/generated/assets/fonts.gen.dart';

class AppTheme {
  static const Color _backgroundColor = Color(0xFF121312);

  static const _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: _backgroundColor,
    pageTransitionsTheme: _pageTransitionsTheme,
    useMaterial3: false,
    fontFamily: FontFamily.roboto,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    extensions: const [
      AppThemeExtension(
        primary: Color(0xFFF6BD00),
        secondary: Color(0xFFE82626),
        background: Color(0xFF121312),
        fill: Color(0xFF282A28),
        primaryText: Color(0xFFFFFFFF),
      ),
    ],
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _backgroundColor,
    pageTransitionsTheme: _pageTransitionsTheme,
    useMaterial3: false,
    fontFamily: FontFamily.roboto,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    extensions: const [
      AppThemeExtension(
        primary: Color(0xFFF6BD00),
        secondary: Color(0xFFE82626),
        background: Color(0xFF121312),
        fill: Color(0xFF282A28),
        primaryText: Color(0xFFFFFFFF),
      ),
    ],
  );
}
