// lib/features/analytics/presentation/analytics_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/animations/fade_slide_transition.dart';
import '../data/analytics_repository.dart';
import '../domain/analytics_summary.dart';
import 'widgets/metric_stat_card.dart';
import 'widgets/revenue_chart_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AnalyticsRepository _repository = AnalyticsRepository();
  late Future<AnalyticsSummary> _analyticsFuture;

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  void _loadAnalytics() {
    setState(() {
      _analyticsFuture = _repository.getAnalyticsSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            Text('Analytics & Reports', style: AppTypography.displayLarge),
            Text(
              'Track performance, revenue metrics, and quotation conversion rates',
              style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Content Body
            Expanded(
              child: FutureBuilder<AnalyticsSummary>(
                future: _analyticsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.accentLime),
                    );
                  }

                  final summary = snapshot.data;

                  if (summary == null) {
                    return const Center(child: Text('Failed to load metrics'));
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KPI Grid
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          crossAxisSpacing: AppSpacing.lg,
                          mainAxisSpacing: AppSpacing.lg,
                          childAspectRatio: 2.2,
                          children: [
                            FadeSlideTransition(
                              child: MetricStatCard(
                                title: 'Total Revenue',
                                value: '\$${summary.totalRevenue.toStringAsFixed(2)}',
                                icon: Icons.attach_money_rounded,
                                accentColor: AppColors.accentLime,
                              ),
                            ),
                            FadeSlideTransition(
                              child: MetricStatCard(
                                title: 'Conversion Rate',
                                value: '${summary.conversionRate}%',
                                icon: Icons.trending_up_rounded,
                                accentColor: AppColors.accentBlue,
                              ),
                            ),
                            FadeSlideTransition(
                              child: MetricStatCard(
                                title: 'Accepted Quotes',
                                value: '${summary.acceptedQuotations} / ${summary.totalQuotations}',
                                icon: Icons.assignment_turned_in_outlined,
                                accentColor: AppColors.success,
                              ),
                            ),
                            FadeSlideTransition(
                              child: MetricStatCard(
                                title: 'Pending Follow-ups',
                                value: '${summary.pendingFollowups}',
                                icon: Icons.pending_actions_rounded,
                                accentColor: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Chart View
                        FadeSlideTransition(
                          child: RevenueChartCard(monthlyData: summary.monthlyData),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}