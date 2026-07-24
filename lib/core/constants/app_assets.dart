// lib/core/constants/app_assets.dart

abstract class AppAssets {
  // Base paths
  static const String _iconsPath = 'assets/icons';
  static const String _imagesPath = 'assets/images';
  static const String _logosPath = 'assets/logos';
  static const String _animationsPath = 'assets/animations';

  // Icons
  static const String appIcon = '$_iconsPath/app_icon.png';

  // Images
  static const String placeholderAvatar = '$_imagesPath/placeholder_avatar.png';
  static const String emptyState = '$_imagesPath/empty_state.png';

  // Logos
  static const String companyLogo = '$_logosPath/company_logo.png';

  // Animations (Lottie)
  static const String loadingSpinner = '$_animationsPath/loading_spinner.json';
}