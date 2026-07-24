// lib/features/settings/data/settings_repository.dart

import 'package:shared_preferences/shared_preferences.dart';
import '../domain/app_settings_model.dart';

class SettingsRepository {
  static const String _keyCompanyName = 'settings_company_name';
  static const String _keyCompanyEmail = 'settings_company_email';
  static const String _keyCurrencySymbol = 'settings_currency_symbol';
  static const String _keyDefaultTaxRate = 'settings_default_tax_rate';
  static const String _keyDarkMode = 'settings_dark_mode';
  static const String _keyNotifications = 'settings_notifications';

  /// Loads application configuration settings from SharedPreferences
  Future<AppSettingsModel> getSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return AppSettingsModel(
      companyName: prefs.getString(_keyCompanyName) ?? 'My Company Inc.',
      companyEmail: prefs.getString(_keyCompanyEmail) ?? 'contact@company.com',
      currencySymbol: prefs.getString(_keyCurrencySymbol) ?? '\$',
      defaultTaxRate: prefs.getDouble(_keyDefaultTaxRate) ?? 0.10,
      isDarkMode: prefs.getBool(_keyDarkMode) ?? true,
      enableNotifications: prefs.getBool(_keyNotifications) ?? true,
    );
  }

  /// Persists settings to local key-value store
  Future<void> saveSettings(AppSettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyCompanyName, settings.companyName);
    await prefs.setString(_keyCompanyEmail, settings.companyEmail);
    await prefs.setString(_keyCurrencySymbol, settings.currencySymbol);
    await prefs.setDouble(_keyDefaultTaxRate, settings.defaultTaxRate);
    await prefs.setBool(_keyDarkMode, settings.isDarkMode);
    await prefs.setBool(_keyNotifications, settings.enableNotifications);
  }
}