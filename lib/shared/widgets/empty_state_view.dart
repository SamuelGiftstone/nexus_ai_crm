// lib/shared/widgets/empty_state_view.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final String description;

  const EmptyStateView({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.emptyState,
            width: 160,
            height: 160,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.inbox_outlined,
                size: 64,
                color: AppColors.textMuted,
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: AppTypography.headingLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            description,
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}