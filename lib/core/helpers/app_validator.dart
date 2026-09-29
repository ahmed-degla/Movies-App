import 'package:movies/generated/l10n/app_localizations.dart';

class AppValidators {
  AppValidators._();

  static String? required(String? value, AppLocalizations strings) {
    if (value == null || value.trim().isEmpty) {
      return strings.requiredField;
    }

    return null;
  }

  static String? email(String? value, AppLocalizations strings) {
    if (value == null || value.trim().isEmpty) {
      return strings.emailRequired;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return strings.validEmail;
    }

    return null;
  }

  static String? password(String? value, AppLocalizations strings) {
    if (value == null || value.isEmpty) {
      return strings.passwordRequired;
    }

    if (value.length < 8) {
      return strings.passwordMinLength;
    }

    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).+$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return strings.passwordComplexity;
    }

    return null;
  }

  static String? confirmPassword(
    String? value,
    String? password,
    AppLocalizations strings,
  ) {
    if (value == null || value.isEmpty) {
      return strings.confirmPasswordRequired;
    }

    if (value != password) {
      return strings.passwordMismatch;
    }

    return null;
  }

  static String? name(String? value, AppLocalizations strings) {
    if (value == null || value.trim().isEmpty) {
      return strings.nameRequired;
    }

    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]{2,}$');

    if (!nameRegex.hasMatch(value.trim())) {
      return strings.validName;
    }

    return null;
  }

  static String? phone(String? value, AppLocalizations strings) {
    if (value == null || value.trim().isEmpty) {
      return strings.phoneRequired;
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return strings.validPhone;
    }

    return null;
  }
}
