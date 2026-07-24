// lib/core/constants/app_constants.dart

abstract class AppConstants {
  static const String appName = 'Nexus AI CRM';
  static const String appVersion = '1.0.0';
  
  // Adjusted for 1366x768 screens (EliteBook Folio 9480m)
  static const double minWindowWidth = 900;
  static const double minWindowHeight = 550;
  
  // Local AI Defaults
  static const String defaultOllamaHost = 'http://localhost:11434';
  static const String defaultGemmaModel = 'gemma:2b';
}