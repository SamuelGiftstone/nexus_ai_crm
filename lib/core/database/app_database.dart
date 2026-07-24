// lib/core/database/app_database.dart

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/customers.dart';
import 'tables/interactions.dart';
import 'tables/quotations.dart';
import 'tables/followups.dart';
import 'tables/ai_history.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Customers,
    Interactions,
    Quotations,
    Followups,
    AiHistory,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'nexus_crm_v1_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}