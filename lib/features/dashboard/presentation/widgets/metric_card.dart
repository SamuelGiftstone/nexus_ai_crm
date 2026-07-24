// lib/features/dashboard/presentation/widgets/metric_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_card.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final String? trend;
  final bool isPositive;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.iconColor = AppColors.accentLime,
    this.trend,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = isPositive ? AppColors.accentLime : Colors.redAccent;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header Row: Title & Icon Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    letterSpacing: 0.9,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: iconColor.withOpacity(0.25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Main Metric Value
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: AppTypography.displayLarge.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ),

          // Subtitle & Optional Trend Pill
          if (subtitle != null || trend != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                if (trend != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: trendColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: trendColor.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPositive
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          size: 10,
                          color: trendColor,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          trend!,
                          style: TextStyle(
                            color: trendColor,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (subtitle != null)
                  Expanded(
                    child: Text(
                      subtitle!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}