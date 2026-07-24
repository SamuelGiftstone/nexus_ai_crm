// lib/core/utils/helpers.dart

import 'package:intl/intl.dart';

abstract class Helpers {
  /// Formats raw numbers into currency strings (e.g., 1240000 -> "$1,240,000.00" or "$1.24M")
  static String formatCurrency(double amount, {bool compact = false}) {
    if (compact) {
      if (amount >= 1000000) {
        return '\$${(amount / 1000000).toStringAsFixed(2)}M';
      } else if (amount >= 1000) {
        return '\$${(amount / 1000).toStringAsFixed(1)}K';
      }
    }
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return formatter.format(amount);
  }

  /// Formats DateTimes into clean human-readable text (e.g., "Jul 23, 2026")
  static String formatDate(DateTime? date, {String format = 'MMM dd, yyyy'}) {
    if (date == null) return 'N/A';
    return DateFormat(format).format(date);
  }

  /// Formats relative time (e.g., "2 hours ago", "Yesterday")
  static String formatRelativeTime(DateTime? date) {
    if (date == null) return 'N/A';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return formatDate(date);
    }
  }

  /// Extracts two-letter initials from a person's full name (e.g., "Mishel Cohen" -> "MC")
  static String getInitials(String name) {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }
}