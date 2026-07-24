// lib/core/database/migrations/migration_strategy.dart

import 'package:drift/drift.dart';
import '../app_database.dart';

abstract class AppDatabaseMigration {
  static MigrationStrategy get strategy {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Future migration steps when adding new columns/tables
      },
      beforeOpen: (details) async {
        // Enable foreign key constraints in SQLite native engine
      },
    );
  }
}