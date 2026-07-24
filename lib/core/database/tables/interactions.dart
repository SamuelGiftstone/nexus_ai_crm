// lib/core/database/tables/interactions.dart

import 'package:drift/drift.dart';
import 'customers.dart';

class Interactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get customerId => text().references(Customers, #id)();
  TextColumn get type => text()(); // Call, Email, Meeting, AI Summary
  TextColumn get notes => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}