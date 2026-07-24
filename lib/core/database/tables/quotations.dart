// lib/core/database/tables/quotations.dart

import 'package:drift/drift.dart';
import 'customers.dart';

class Quotations extends Table {
  TextColumn get id => text()();
  TextColumn get customerId => text().references(Customers, #id)();
  RealColumn get totalAmount => real()();
  TextColumn get status => text().withDefault(const Constant('Draft'))(); // Draft, Sent, Accepted
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}