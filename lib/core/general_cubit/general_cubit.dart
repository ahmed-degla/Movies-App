import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit._() : super(const GeneralState()) {
    unawaited(init());
  }

  static GeneralCubit of(BuildContext context) => context.read<GeneralCubit>();
  static final GeneralCubit instance = GeneralCubit._();
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

  Future<void> changeTheme(ThemeMode mode) async {
    await _prefs.setString(_themeModeKey, switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    });

    emit(state.copyWith(themeMode: mode));
  }

  Future<void> toggleTheme() async {
    final newTheme = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await changeTheme(newTheme);
  }

  Future<void> changeLanguage(String code) async {
    final locale = Locale(code);

    await _prefs.setString(_languageKey, code);

    emit(state.copyWith(locale: locale));
  }

  bool get isDark => state.isDark;

  bool get isArabic => state.isArabic;
}
