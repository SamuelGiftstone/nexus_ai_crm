// lib/features/dashboard/data/dashboard_repository.dart

import 'package:drift/drift.dart';
import 'package:nexus_ai_crm/core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../shared/models/customer_model.dart';
import '../domain/dashboard_stats.dart';

class DashboardRepository {
  final AppDatabase _db;

  DashboardRepository({AppDatabase? db})
      : _db = db ?? DatabaseProvider.instance;

  Future<DashboardStats> getDashboardStats() async {
    final contacts = await _db.select(_db.customers).get();

    if (contacts.isEmpty) {
      return DashboardStats.empty();
    }

    int totalContacts = contacts.length;
    double totalValue = 0.0;
    int activeLeads = 0;
    int wonDeals = 0;
    int closedDeals = 0;

    final Map<String, double> stageMap = {
      'Lead': 0.0,
      'Qualified': 0.0,
      'Proposal': 0.0,
      'Won': 0.0,
      'Lost': 0.0,
    };

    for (final c in contacts) {
      final value = c.dealValue ?? 0.0;
      final status = c.status ?? 'Lead';

      totalValue += value;
      stageMap[status] = (stageMap[status] ?? 0.0) + value;

      if (status == 'Lead' || status == 'Qualified' || status == 'Proposal') {
        activeLeads++;
      } else if (status == 'Won') {
        wonDeals++;
        closedDeals++;
      } else if (status == 'Lost') {
        closedDeals++;
      }
    }

    final winRate = closedDeals > 0 ? (wonDeals / closedDeals) * 100 : 0.0;

    // Fetch 5 most recent entries using _db.customers
    final recentQuery = _db.select(_db.customers)
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
      ])
      ..limit(5);

    final recentRows = await recentQuery.get();
    final recentLeads = recentRows.map((row) {
      return CustomerModel(
        id: row.id,
        firstName: row.firstName,
        lastName: row.lastName,
        company: row.company,
        position: row.position,
        email: row.email,
        phone: row.phone,
        dealValue: row.dealValue ?? 0.0,
        status: row.status ?? 'Lead',
        createdAt: row.createdAt,
      );
    }).toList();

    return DashboardStats(
      totalContacts: totalContacts,
      totalDealValue: totalValue,
      activeLeads: activeLeads,
      winRatePercentage: winRate,
      recentLeads: recentLeads,
      pipelineValueByStage: stageMap,
    );
  }
}