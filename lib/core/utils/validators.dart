// lib/core/utils/validators.dart

abstract class Validators {
  /// Validates required text inputs
  static String? required(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// Validates standard email format
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&'
      r"'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates numeric monetary or revenue inputs
  static String? currency(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    final number = double.tryParse(value.replaceAll(',', '').trim());
    if (number == null || number < 0) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  /// Validates optional phone number structure
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone is optional
    }
    final phoneRegex = RegExp(r'^\+?[0-9\s\-\(\)]{7,20}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}