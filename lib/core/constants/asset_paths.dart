// lib/core/constants/asset_paths.dart

abstract class AssetPaths {
  // Base Directories
  static const String _baseIcons = 'assets/icons';
  static const String _baseImages = 'assets/images';
  static const String _baseLogos = 'assets/logos';
  static const String _baseAnimations = 'assets/animations';

  // Logos
  static const String appLogo = '$_baseLogos/nexus_logo.svg';
  static const String appLogoIcon = '$_baseLogos/nexus_icon.svg';
  static const String gemmaLogo = '$_baseLogos/gemma_logo.svg';
  static const String ollamaLogo = '$_baseLogos/ollama_logo.svg';

  // Icons
  static const String iconCopilot = '$_baseIcons/copilot.svg';
  static const String iconPipeline = '$_baseIcons/pipeline.svg';
  static const String iconDuplicates = '$_baseIcons/duplicates.svg';
  static const String iconContacts = '$_baseIcons/contacts.svg';
  static const String iconQuotations = '$_baseIcons/quotations.svg';
  static const String iconAnalytics = '$_baseIcons/analytics.svg';

  // Images & Avatars (Placeholders)
  static const String defaultUserAvatar = '$_baseImages/avatars/default_user.png';
  static const String aiAvatar = '$_baseImages/avatars/ai_assistant.png';
  static const String emptyStateIllustration = '$_baseImages/illustrations/empty_state.svg';

  // Lottie / Rive Animations
  static const String aiThinkingAnimation = '$_baseAnimations/ai_thinking.json';
  static const String startupLoader = '$_baseAnimations/startup_loader.json';
}