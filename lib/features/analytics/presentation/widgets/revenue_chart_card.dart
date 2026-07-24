// lib/features/analytics/presentation/widgets/revenue_chart_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_card.dart';
import '../../domain/monthly_revenue.dart';

class RevenueChartCard extends StatelessWidget {
  final List<MonthlyRevenue> monthlyData;

  const RevenueChartCard({super.key, required this.monthlyData});

  @override
  Widget build(BuildContext context) {
    final maxRevenue = monthlyData.fold<double>(
      0.0,
      (max, item) => item.revenue > max ? item.revenue : max,
    );

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Revenue Performance', style: AppTypography.headingMedium),
          Text(
            'Monthly closed sales comparison over the last 6 months',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: monthlyData.map((data) {
                final heightFactor = maxRevenue > 0 ? (data.revenue / maxRevenue) : 0.0;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '\$${data.revenue.toStringAsFixed(0)}',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 32,
                      height: 140 * heightFactor + 8, // Minimum bar height of 8
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(data.month, style: AppTypography.bodySmallBold),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}