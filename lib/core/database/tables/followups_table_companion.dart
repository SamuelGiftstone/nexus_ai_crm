// lib/core/database/tables/followups_table_companion.dart

import 'package:drift/drift.dart';
import 'customers.dart';

/// Drift SQLite table definition for customer follow-up actions and reminders
@DataClassName('FollowupEntry')
class FollowupsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get contactId => integer().references(Customers, #id)();
  TextColumn get contactName => text().withLength(min: 1, max: 100)();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get note => text().nullable()();
  
  /// Stores enum string values: email, call, meeting, task
  TextColumn get type => text().withDefault(const Constant('task'))();
  
  /// Stores enum string values: low, medium, high, urgent
  TextColumn get priority => text().withDefault(const Constant('medium'))();
  
  /// Stores enum string values: pending, completed, cancelled, overdue
  TextColumn get status => text().withDefault(const Constant('pending'))();
  
  DateTimeColumn get scheduledAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}