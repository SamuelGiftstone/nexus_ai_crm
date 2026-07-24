// lib/features/splash/presentation/startup_status_tile.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

enum StartupStatus { pending, loading, success, warning, error }

class StartupStatusTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final StartupStatus status;

  const StartupStatusTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget;

    switch (status) {
      case StartupStatus.loading:
        leadingWidget = const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.accentLime,
          ),
        );
        break;
      case StartupStatus.success:
        leadingWidget = const Icon(
          Icons.check_circle_rounded,
          size: 18,
          color: AppColors.success,
        );
        break;
      case StartupStatus.warning:
        leadingWidget = const Icon(
          Icons.warning_amber_rounded,
          size: 18,
          color: AppColors.warning,
        );
        break;
      case StartupStatus.error:
        leadingWidget = const Icon(
          Icons.error_outline_rounded,
          size: 18,
          color: AppColors.error,
        );
        break;
      case StartupStatus.pending:
      default:
        leadingWidget = Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: const BoxDecoration(
            color: AppColors.textMuted,
            shape: BoxShape.circle,
          ),
        );
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          SizedBox(width: 24, height: 24, child: Center(child: leadingWidget)),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodySmall.copyWith(
                    color: status == StartupStatus.pending
                        ? AppColors.textMuted
                        : AppColors.textPrimary,
                    fontWeight: status == StartupStatus.loading
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}