// lib/features/pipeline/presentation/widgets/pipeline_column.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import 'deal_card.dart';

class PipelineColumn extends StatelessWidget {
  final String stageName;
  final String totalValue;
  final int count;
  final List<Map<String, String>> deals;

  const PipelineColumn({
    super.key,
    required this.stageName,
    required this.totalValue,
    required this.count,
    required this.deals,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stage Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(stageName, style: AppTypography.headingMedium),
                  const SizedBox(width: AppSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text('$count', style: AppTypography.bodySmall),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 16, color: AppColors.textMuted),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(totalValue, style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
          const SizedBox(height: AppSpacing.md),

          // Cards Stream
          Expanded(
            child: ListView.builder(
              itemCount: deals.length,
              itemBuilder: (context, index) {
                final deal = deals[index];
                return DealCard(
                  title: deal['title']!,
                  company: deal['company']!,
                  value: deal['value']!,
                  probability: deal['probability']!,
                  avatarUrl: deal['avatarUrl']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}