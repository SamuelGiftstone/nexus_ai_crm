// lib/core/database/tables/ai_history.dart

import 'package:drift/drift.dart';
import 'customers.dart';

class AiHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get customerId => text().nullable().references(Customers, #id)();
  TextColumn get prompt => text()();
  TextColumn get response => text()();
  TextColumn get actionType => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}