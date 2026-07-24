// lib/core/database/tables/customers.dart

import 'package:drift/drift.dart';

class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get firstName => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  TextColumn get company => text().nullable()();
  TextColumn get position => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  RealColumn get dealValue => real().withDefault(const Constant(0.0))();
  TextColumn get status => text().withDefault(const Constant('Lead'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}