// lib/features/duplicates/presentation/widgets/duplicate_card.dart

import 'package:flutter/material.dart';
import 'package:nexus_ai_crm/features/duplicates/domain/duplicate_cluster.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/custom_card.dart';
import '../../../../shared/widgets/status_badge.dart';

class DuplicateCard extends StatelessWidget {
  final DuplicateCluster cluster;
  final VoidCallback onResolve;

  const DuplicateCard({
    super.key,
    required this.cluster,
    required this.onResolve,
  });

  @override
  Widget build(BuildContext context) {
    final candidate = cluster.duplicateCandidates.first;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Text(cluster.matchTypeLabel, style: AppTypography.headingMedium),
                ],
              ),
              StatusBadge(
                label: '${(cluster.confidenceScore * 100).toInt()}% Match',
                color: AppColors.accentPurple,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Side-by-Side Comparison
          Row(
            children: [
              Expanded(
                child: _buildContactPreview('Primary Record', cluster.primaryContact),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Icon(Icons.compare_arrows_rounded, color: AppColors.textMuted),
              ),
              Expanded(
                child: _buildContactPreview('Duplicate Candidate', candidate),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Action Button
          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              label: 'Review & Merge',
              icon: Icons.merge_type_rounded,
              variant: AppButtonVariant.primary,
              onPressed: onResolve,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactPreview(String label, dynamic contact) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(contact.fullName, style: AppTypography.bodySmallBold),
          Text(
            contact.email,
            style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${contact.company ?? "No company"} • \$${contact.dealValue.toStringAsFixed(0)}',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}