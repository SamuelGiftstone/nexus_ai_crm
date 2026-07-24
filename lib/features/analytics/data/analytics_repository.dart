// lib/features/analytics/data/analytics_repository.dart

import 'package:drift/drift.dart';
import 'package:nexus_ai_crm/core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../domain/analytics_summary.dart';
import '../domain/monthly_revenue.dart';

class AnalyticsRepository {
  final AppDatabase _db;

  AnalyticsRepository({AppDatabase? db})
      : _db = db ?? DatabaseProvider.instance;

  /// Aggregates analytical metrics from quotations and followups
  Future<AnalyticsSummary> getAnalyticsSummary() async {
    // Replaced _db.quotationsTable with _db.quotations
    final quotations = await _db.select(_db.quotations).get();
    // Replaced _db.followupsTable with _db.followups
    final followups = await _db.select(_db.followups).get();

    final totalCount = quotations.length;
    final acceptedCount = quotations.where((q) => q.status == 'accepted').length;

    double totalRev = 0.0;
    for (final q in quotations) {
      if (q.status == 'accepted') {
        totalRev += q.totalAmount;
      }
    }
    // Calculate pendingCount before constructing your model/result
    final pendingCount = followups.where((f) => !f.isCompleted && f.dueDate.isAfter(DateTime.now())).length;
    final completedCount = followups.where((f) => f.isCompleted).length;
    final rate = totalCount > 0 ? (acceptedCount / totalCount) * 100 : 0.0;

    // Monthly breakdown over the last 6 months
    final now = DateTime.now();
    final List<MonthlyRevenue> monthlyData = [];

    for (int i = 5; i >= 0; i--) {
      final targetMonth = DateTime(now.year, now.month - i, 1);
      final monthName = _getMonthName(targetMonth.month);

      double monthRev = 0.0;
      int monthQuoteCount = 0;

      for (final q in quotations) {
        if (q.createdAt.year == targetMonth.year &&
            q.createdAt.month == targetMonth.month) {
          monthQuoteCount++;
          if (q.status == 'accepted') {
            monthRev += q.totalAmount;
          }
        }
      }

      monthlyData.add(MonthlyRevenue(
        month: monthName,
        revenue: monthRev,
        quotationsCount: monthQuoteCount,
      ));
    }

    return AnalyticsSummary(
      totalRevenue: totalRev,
      totalQuotations: totalCount,
      acceptedQuotations: acceptedCount,
      pendingFollowups: pendingCount,
      conversionRate: double.parse(rate.toStringAsFixed(1)),
      monthlyData: monthlyData,
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}