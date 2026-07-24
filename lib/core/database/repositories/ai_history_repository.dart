// lib/core/database/repositories/ai_history_repository.dart

import 'package:drift/drift.dart';
import '../app_database.dart';

class AiHistoryRepository {
  final AppDatabase _db;

  AiHistoryRepository({AppDatabase? db}) : _db = db ?? AppDatabase();

  Future<int> logInteraction({
    required String prompt,
    required String response,
    String? customerId,
    String? actionType,
  }) {
    return _db.into(_db.aiHistory).insert(
          AiHistoryCompanion.insert(
            prompt: prompt,
            response: response,
            customerId: Value(customerId),
            actionType: Value(actionType),
          ),
        );
  }

  // Changed to AiHistoryData
  Future<List<AiHistoryData>> getHistoryForCustomer(String customerId) {
    return (_db.select(_db.aiHistory)
          ..where((tbl) => tbl.customerId.equals(customerId)))
        .get();
  }
}