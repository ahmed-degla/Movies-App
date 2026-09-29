import 'package:movies/core/utils/app_utils.dart';

class AppValidators {
  AppValidators._();

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr.requiredField;
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr.emailRequired;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return tr.validEmail;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return tr.passwordRequired;
    }

    if (value.length < 8) {
      return tr.passwordMinLength;
    }

    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).+$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return tr.passwordComplexity;
    }

    return null;
  }

  static String? confirmPassword(
    String? value,
    String? password,
  ) {
    if (value == null || value.isEmpty) {
      return tr.confirmPasswordRequired;
    }

    if (value != password) {
      return tr.passwordMismatch;
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr.nameRequired;
    }

    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]{2,}$');

    if (!nameRegex.hasMatch(value.trim())) {
      return tr.validName;
    }

    return null;
  }

  static String? phone(String? value, ) {
    if (value == null || value.trim().isEmpty) {
      return tr.phoneRequired;
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return tr.validPhone;
    }

    return null;
  }
}
