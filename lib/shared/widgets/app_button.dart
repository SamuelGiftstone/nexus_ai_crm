// lib/shared/widgets/app_button.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

enum AppButtonVariant { primary, secondary, outline, text, lime }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool isLoading;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case AppButtonVariant.lime:
        backgroundColor = AppColors.accentLime;
        foregroundColor = Colors.black;
        break;
      case AppButtonVariant.secondary:
        backgroundColor = AppColors.surfaceDark;
        foregroundColor = AppColors.textPrimary;
        borderSide = const BorderSide(color: AppColors.borderSubtle);
        break;
      case AppButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.textPrimary;
        borderSide = const BorderSide(color: AppColors.borderHighlight);
        break;
      case AppButtonVariant.text:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.textSecondary;
        break;
      case AppButtonVariant.primary:
      default:
        backgroundColor = AppColors.accentBlue;
        foregroundColor = Colors.white;
        break;
    }

    final childWidget = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: foregroundColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ] else if (icon != null) ...[
          Icon(icon, size: 16, color: foregroundColor),
          const SizedBox(width: AppSpacing.xs + 2),
        ],
        Text(
          label,
          style: AppTypography.labelBold.copyWith(color: foregroundColor),
        ),
      ],
    );

    return SizedBox(
      width: width,
      height: 40,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderMd,
            side: borderSide,
          ),
        ),
        child: childWidget,
      ),
    );
  }
}