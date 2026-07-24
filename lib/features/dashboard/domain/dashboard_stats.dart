// lib/features/dashboard/domain/dashboard_stats.dart

import '../../../../shared/models/customer_model.dart';

class DashboardStats {
  final int totalContacts;
  final double totalDealValue;
  final int activeLeads;
  final double winRatePercentage;
  final List<CustomerModel> recentLeads;
  final Map<String, double> pipelineValueByStage;

  const DashboardStats({
    required this.totalContacts,
    required this.totalDealValue,
    required this.activeLeads,
    required this.winRatePercentage,
    required this.recentLeads,
    required this.pipelineValueByStage,
  });

  factory DashboardStats.empty() {
    return const DashboardStats(
      totalContacts: 0,
      totalDealValue: 0.0,
      activeLeads: 0,
      winRatePercentage: 0.0,
      recentLeads: [],
      pipelineValueByStage: {},
    );
  }
}