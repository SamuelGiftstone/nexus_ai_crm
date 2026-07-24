// lib/features/analytics/domain/analytics_summary.dart

import 'monthly_revenue.dart';

class AnalyticsSummary {
  final double totalRevenue;
  final int totalQuotations;
  final int acceptedQuotations;
  final int pendingFollowups;
  final double conversionRate; // Percentage (0.0 to 100.0)
  final List<MonthlyRevenue> monthlyData;

  const AnalyticsSummary({
    required this.totalRevenue,
    required this.totalQuotations,
    required this.acceptedQuotations,
    required this.pendingFollowups,
    required this.conversionRate,
    required this.monthlyData,
  });
}