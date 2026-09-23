import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralState {
  const GeneralState({
    this.themeMode = ThemeMode.dark,
    this.locale = const Locale('en'),
  });

  final ThemeMode themeMode;
  final Locale locale;

  bool get isDark => themeMode == ThemeMode.dark;

  bool get isArabic => locale.languageCode == 'ar';

  GeneralState copyWith({ThemeMode? themeMode, Locale? locale}) => GeneralState(
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
  );
}

@singleton
class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralState());

  static GeneralCubit of(BuildContext context) => context.read<GeneralCubit>();

  static const String _themeModeKey = 'theme_mode';
  static const String _languageKey = 'language';

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    final theme = _prefs.getString(_themeModeKey);
    final language = _prefs.getString(_languageKey);

    final themeMode = switch (theme) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark,
    };

    final locale = switch (language) {
      'ar' => const Locale('ar'),
      'en' => const Locale('en'),
      _ => const Locale('en'),
    };

    emit(state.copyWith(themeMode: themeMode, locale: locale));
  }

  Future<void> changeLanguage(String code) async {
    final locale = Locale(code);

    emit(state.copyWith(locale: locale));

    await _prefs.setString(_languageKey, code);
  }

  Future<void> changeTheme(ThemeMode mode) async {
    final theme = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    await _prefs.setString(_themeModeKey, theme);

    emit(state.copyWith(themeMode: mode));
  }

  Future<void> toggleTheme() async {
    final newTheme = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await changeTheme(newTheme);
  }

  bool get isDark => state.isDark;

  bool get isArabic => state.isArabic;
}
