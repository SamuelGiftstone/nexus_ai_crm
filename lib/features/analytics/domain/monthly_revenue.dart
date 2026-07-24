// lib/features/analytics/domain/monthly_revenue.dart

class MonthlyRevenue {
  final String month; // e.g. "Jan", "Feb"
  final double revenue;
  final int quotationsCount;

  const MonthlyRevenue({
    required this.month,
    required this.revenue,
    required this.quotationsCount,
  });
}