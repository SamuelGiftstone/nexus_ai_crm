// lib/features/settings/domain/app_settings_model.dart

class AppSettingsModel {
  final String companyName;
  final String companyEmail;
  final String currencySymbol;
  final double defaultTaxRate;
  final bool isDarkMode;
  final bool enableNotifications;

  const AppSettingsModel({
    required this.companyName,
    required this.companyEmail,
    required this.currencySymbol,
    required this.defaultTaxRate,
    required this.isDarkMode,
    required this.enableNotifications,
  });

  factory AppSettingsModel.defaultSettings() => const AppSettingsModel(
        companyName: 'My Company Inc.',
        companyEmail: 'contact@company.com',
        currencySymbol: '\$',
        defaultTaxRate: 0.10,
        isDarkMode: true,
        enableNotifications: true,
      );

  AppSettingsModel copyWith({
    String? companyName,
    String? companyEmail,
    String? currencySymbol,
    double? defaultTaxRate,
    bool? isDarkMode,
    bool? enableNotifications,
  }) {
    return AppSettingsModel(
      companyName: companyName ?? this.companyName,
      companyEmail: companyEmail ?? this.companyEmail,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      defaultTaxRate: defaultTaxRate ?? this.defaultTaxRate,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      enableNotifications: enableNotifications ?? this.enableNotifications,
    );
  }
}