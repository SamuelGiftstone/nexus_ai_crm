// lib/features/copilot/presentation/widgets/prompt_input_box.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class PromptInputBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;
  final bool isLoading;

  const PromptInputBox({
    super.key,
    required this.controller,
    required this.onSubmitted,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.accentLime,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTypography.bodyMedium,
              onSubmitted: (_) => isLoading ? null : onSubmitted(),
              decoration: InputDecoration(
                hintText: 'Ask Copilot anything about your CRM database, deals, or contacts...',
                hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isLoading ? null : onSubmitted,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isLoading ? AppColors.surfaceDark : AppColors.accentLime,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.textMuted,
                        ),
                      )
                    : const Icon(
                        Icons.arrow_upward_rounded,
                        color: AppColors.surfaceDark,
                        size: 18,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}