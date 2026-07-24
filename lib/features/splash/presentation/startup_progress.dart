// lib/features/splash/presentation/startup_progress.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class StartupProgress extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String statusText;

  const StartupProgress({
    super.key,
    required this.progress,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).clamp(0, 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              statusText,
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            Text(
              '$percentage%',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.accentLime,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs + 2),
        ClipRRect(
          borderRadius: AppRadius.borderSm,
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.surfaceDark,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentLime),
          ),
        ),
      ],
    );
  }
}