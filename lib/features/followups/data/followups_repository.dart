// lib/features/followups/data/followups_repository.dart

import 'package:drift/drift.dart';
import 'package:nexus_ai_crm/core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../domain/followup_model.dart';

class FollowupsRepository {
  final AppDatabase _db;

  FollowupsRepository({AppDatabase? db})
      : _db = db ?? DatabaseProvider.instance;

  /// Fetches all stored follow-up records from local SQLite
  Future<List<FollowupModel>> getFollowups() async {
    final rows = await _db.select(_db.followups).get();

    return rows.map((row) {
      final isOverdue = !row.isCompleted && row.dueDate.isBefore(DateTime.now());
      
      final status = row.isCompleted
          ? FollowupStatus.completed
          : (isOverdue ? FollowupStatus.overdue : FollowupStatus.pending);

      return FollowupModel(
        id: row.id,
        contactId: int.tryParse(row.customerId) ?? 0,
        contactName: 'Contact #${row.customerId}', // Fallback contact display name
        title: row.title,
        type: FollowupType.task,                   // Default type fallback
        priority: FollowupPriority.medium,        // Default priority fallback
        status: status,
        scheduledAt: row.dueDate,
        completedAt: row.isCompleted ? row.dueDate : null,
      );
    }).toList();
  }

  /// Inserts or updates a follow-up action
  Future<int> saveFollowup(FollowupModel followup) async {
    final companion = FollowupsCompanion(
      customerId: Value(followup.contactId.toString()),
      title: Value(followup.title),
      dueDate: Value(followup.scheduledAt),
      isCompleted: Value(followup.status == FollowupStatus.completed),
      completedAt: Value(followup.completedAt ?? DateTime.now()),
    );

    if (followup.id != null) {
      await (_db.update(_db.followups)
            ..where((tbl) => tbl.id.equals(followup.id!)))
          .write(companion);
      return followup.id!;
    } else {
      return await _db.into(_db.followups).insert(companion);
    }
  }

  /// Marks a follow-up activity as completed
  Future<void> markCompleted(int id) async {
    await (_db.update(_db.followups)..where((tbl) => tbl.id.equals(id))).write(
      FollowupsCompanion(
        isCompleted: const Value(true),
        completedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Removes a follow-up entry by ID
  Future<void> deleteFollowup(int id) async {
    await (_db.delete(_db.followups)..where((tbl) => tbl.id.equals(id))).go();
  }
}