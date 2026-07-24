import 'package:flutter/material.dart';

abstract class AppColors {
  // Backgrounds & Surface
  static const Color background = Color(0xFF131316);
  static const Color surfaceDark = Color(0xFF1C1C21);
  static const Color surfaceCard = Color(0xFF24242B);
  static const Color surfaceCardHover = Color(0xFF2C2C35);
  
  // Signature Accents (Matched to reference UI)
  static const Color accentLime = Color(0xFFE2FF00);   // Neon Yellow/Lime highlight
  static const Color accentPurple = Color(0xFF7A22FF); // Electric Purple accent
  static const Color accentBlue = Color(0xFF2563EB);   // Enterprise Royal Blue

  // Neutral Tones
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color borderSubtle = Color(0xFF2E2E38);
  static const Color borderHighlight = Color(0xFF3F3F4E);

  // Status Indicators
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Gradients
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF7A22FF), Color(0xFF5B16C9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient limeGradient = LinearGradient(
    colors: [Color(0xFFE2FF00), Color(0xFFB0CC00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}