// lib/features/dashboard/presentation/widgets/pipeline_breakdown_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_card.dart';

class PipelineBreakdownCard extends StatelessWidget {
  final Map<String, double> stageValues;

  const PipelineBreakdownCard({
    super.key,
    required this.stageValues,
  });

  Color _getStageColor(String stage) {
    switch (stage) {
      case 'Qualified':
        return AppColors.accentPurple;
      case 'Proposal':
        return AppColors.warning;
      case 'Won':
        return AppColors.success;
      case 'Lost':
        return AppColors.error;
      case 'Lead':
      default:
        return AppColors.accentBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double total = stageValues.values.fold(0.0, (sum, val) => sum + val);

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Title and Total Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pipeline Breakdown', style: AppTypography.headingLarge),
                    const SizedBox(height: 4),
                    Text(
                      'Distribution of deal volumes across sales funnel stages.',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              if (total > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Text(
                    '\$${total.toStringAsFixed(0)}',
                    style: AppTypography.bodySmallBold.copyWith(
                      color: Colors.white,
                      fontSize: 11,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Unified Segmented Stack Bar Visualizer
          if (total > 0) ...[
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(4),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: stageValues.entries.map((entry) {
                  final val = entry.value;
                  final percentage = total > 0 ? (val / total) : 0.0;
                  if (percentage <= 0) return const SizedBox.shrink();

                  return Expanded(
                    flex: (percentage * 1000).toInt(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0.5),
                      decoration: BoxDecoration(
                        color: _getStageColor(entry.key),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ] else ...[
            const SizedBox(height: AppSpacing.md),
          ],

          // Breakdown List
          ...stageValues.entries.map((entry) {
            final stage = entry.key;
            final val = entry.value;
            final percentage = total > 0 ? (val / total) : 0.0;
            final stageColor = _getStageColor(stage);

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stage Row Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Glowing Indicator Dot
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: stageColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: stageColor.withOpacity(0.6),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(stage, style: AppTypography.bodySmallBold),
                        ],
                      ),
                      Text(
                        '\$${val.toStringAsFixed(0)} (${(percentage * 100).toStringAsFixed(0)}%)',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Enhanced Custom Progress Bar
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth * percentage.clamp(0.0, 1.0);
                      return Stack(
                        children: [
                          Container(
                            height: 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              borderRadius: AppRadius.borderSm,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 6,
                            width: width,
                            decoration: BoxDecoration(
                              color: stageColor,
                              borderRadius: AppRadius.borderSm,
                              boxShadow: [
                                BoxShadow(
                                  color: stageColor.withOpacity(0.35),
                                  blurRadius: 6,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}