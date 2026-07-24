// lib/core/utils/extensions.dart

import 'package:flutter/material.dart';

extension StringCasingExtension on String {
  /// Capitalizes the first letter of a string
  String toCapitalized() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts a string to Title Case
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.toCapitalized()).join(' ');
  }
}

extension DateTimeExtension on DateTime {
  /// Checks if two dates fall on the same day
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Checks if date is today
  bool get isToday => isSameDay(DateTime.now());
}

extension BuildContextThemeExtension on BuildContext {
  /// Quick access to Theme and TextTheme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Quick access to ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Quick access to Media Query Size
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
}