// lib/core/database/repositories/customer_repository.dart

import 'package:drift/drift.dart';
import '../app_database.dart';

class CustomerRepository {
  final AppDatabase _db;

  CustomerRepository({AppDatabase? db}) : _db = db ?? AppDatabase();

  /// Reactive stream of all customers for live UI bindings
  Stream<List<Customer>> watchAllCustomers() {
    return _db.select(_db.customers).watch();
  }

  /// Search customers by name or company
  Future<List<Customer>> searchCustomers(String query) {
    return (_db.select(_db.customers)
          ..where((tbl) =>
              tbl.firstName.like('%$query%') |
              tbl.lastName.like('%$query%') |
              tbl.company.like('%$query%')))
        .get();
  }

  /// Insert or update customer
  Future<int> saveCustomer(CustomersCompanion customer) {
    return _db.into(_db.customers).insertOnConflictUpdate(customer);
  }

  /// Delete customer record
  Future<int> deleteCustomer(String id) {
    return (_db.delete(_db.customers)..where((tbl) => tbl.id.equals(id))).go();
  }
}