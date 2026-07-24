// lib/core/database/tables/followups.dart

import 'package:drift/drift.dart';
import 'customers.dart';

class Followups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get customerId => text()();
  TextColumn get title => text()();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  
  // Make sure .nullable() is called here
  DateTimeColumn get completedAt => dateTime().nullable()();
}