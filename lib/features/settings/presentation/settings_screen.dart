// lib/features/settings/presentation/settings_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/animations/fade_slide_transition.dart';
import '../../../shared/widgets/app_button.dart';
import '../data/settings_repository.dart';
import '../domain/app_settings_model.dart';
import 'widgets/settings_toggle_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsRepository _repository = SettingsRepository();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _currencyController;
  late TextEditingController _taxController;

  bool _isDarkMode = true;
  bool _enableNotifications = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currencyController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final settings = await _repository.getSettings();

    _nameController = TextEditingController(text: settings.companyName);
    _emailController = TextEditingController(text: settings.companyEmail);
    _currencyController = TextEditingController(text: settings.currencySymbol);
    _taxController = TextEditingController(text: (settings.defaultTaxRate * 100).toStringAsFixed(0));

    setState(() {
      _isDarkMode = settings.isDarkMode;
      _enableNotifications = settings.enableNotifications;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    final updated = AppSettingsModel(
      companyName: _nameController.text.trim(),
      companyEmail: _emailController.text.trim(),
      currencySymbol: _currencyController.text.trim(),
      defaultTaxRate: (double.tryParse(_taxController.text) ?? 10.0) / 100,
      isDarkMode: _isDarkMode,
      enableNotifications: _enableNotifications,
    );

    await _repository.saveSettings(updated);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Settings saved successfully'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  InputDecoration _buildInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
      prefixIcon: Icon(icon, size: 16, color: AppColors.textMuted),
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.accentLime),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.accentLime.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: AppColors.accentLime),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(title, style: AppTypography.bodyMedium),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.accentLime),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Desktop Header Pattern matching Quotations & Companies
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Settings', style: AppTypography.displayLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Manage business profile, taxation, and desktop preference defaults',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
                AppButton(
                  label: 'Save Preferences',
                  icon: Icons.save_rounded,
                  variant: AppButtonVariant.primary,
                  onPressed: _saveSettings,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Desktop Container Grid Card matching other features
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    children: [
                      // Business Information Section
                      _buildSectionHeader('Business Information', Icons.business_center_outlined),
                      const SizedBox(height: AppSpacing.md),
                      FadeSlideTransition(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Company Name', style: AppTypography.bodySmallBold),
                                  const SizedBox(height: AppSpacing.xs),
                                  TextField(
                                    controller: _nameController,
                                    style: AppTypography.bodySmall,
                                    decoration: _buildInputDecoration('Enter company name', Icons.domain_rounded),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Company Email', style: AppTypography.bodySmallBold),
                                  const SizedBox(height: AppSpacing.xs),
                                  TextField(
                                    controller: _emailController,
                                    style: AppTypography.bodySmall,
                                    decoration: _buildInputDecoration('Enter corporate email', Icons.email_outlined),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      const Divider(color: AppColors.borderSubtle),
                      const SizedBox(height: AppSpacing.lg),

                      // Financial Defaults Section
                      _buildSectionHeader('Financial Defaults', Icons.account_balance_wallet_outlined),
                      const SizedBox(height: AppSpacing.md),
                      FadeSlideTransition(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Currency Symbol', style: AppTypography.bodySmallBold),
                                  const SizedBox(height: AppSpacing.xs),
                                  TextField(
                                    controller: _currencyController,
                                    style: AppTypography.bodySmall,
                                    decoration: _buildInputDecoration('e.g. \$, €, £', Icons.attach_money_rounded),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Default Tax Rate (%)', style: AppTypography.bodySmallBold),
                                  const SizedBox(height: AppSpacing.xs),
                                  TextField(
                                    controller: _taxController,
                                    keyboardType: TextInputType.number,
                                    style: AppTypography.bodySmall,
                                    decoration: _buildInputDecoration('e.g. 10', Icons.percent_rounded),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      const Divider(color: AppColors.borderSubtle),
                      const SizedBox(height: AppSpacing.lg),

                      // Application Preferences Section
                      _buildSectionHeader('Application Preferences', Icons.tune_rounded),
                      const SizedBox(height: AppSpacing.md),
                      FadeSlideTransition(
                        child: Column(
                          children: [
                            SettingsToggleTile(
                              title: 'Dark Theme Mode',
                              subtitle: 'Use high-contrast dark theme mode across desktop frames',
                              icon: Icons.dark_mode_outlined,
                              value: _isDarkMode,
                              onChanged: (val) => setState(() => _isDarkMode = val),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            SettingsToggleTile(
                              title: 'Follow-up Reminders',
                              subtitle: 'Receive notification alerts for overdue customer tasks',
                              icon: Icons.notifications_active_outlined,
                              value: _enableNotifications,
                              onChanged: (val) => setState(() => _enableNotifications = val),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}