// lib/features/contacts/data/contacts_repository.dart

import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';

class ContactsRepository {
  final AppDatabase _db;

  ContactsRepository(this._db);

  /// Fetch all customers
  Future<List<Customer>> getAllContacts() async {
    return await _db.select(_db.customers).get();
  }

  /// Filter contacts by search query or status
  Future<List<Customer>> getFilteredContacts({
    String? query,
    String? statusFilter,
    String? sortBy,
  }) async {
    final statement = _db.select(_db.customers);

    if (query != null && query.isNotEmpty) {
      final lowercaseQuery = '%${query.toLowerCase()}%';
      statement.where(
        (tbl) =>
            tbl.firstName.lower().like(lowercaseQuery) |
            tbl.lastName.lower().like(lowercaseQuery) |
            tbl.email.lower().like(lowercaseQuery) |
            tbl.company.lower().like(lowercaseQuery),
      );
    }

    if (statusFilter != null && statusFilter != 'all' && statusFilter.isNotEmpty) {
      statement.where((tbl) => tbl.status.equals(statusFilter));
    }

    if (sortBy != null) {
      switch (sortBy) {
        case 'name':
          statement.orderBy([(tbl) => OrderingTerm.asc(tbl.firstName)]);
          break;
        case 'dealValue':
          statement.orderBy([(tbl) => OrderingTerm.desc(tbl.dealValue)]);
          break;
        case 'createdAt':
          statement.orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);
          break;
      }
    }

    return await statement.get();
  }

  /// Insert a new customer
  Future<int> addContact({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    String? company,
    String? status,
    double? dealValue,
  }) async {
    return await _db.into(_db.customers).insert(
          CustomersCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: Value(email),
            phone: Value(phone),
            company: Value(company),
            status: Value(status ?? 'lead'),
            dealValue: Value(dealValue ?? 0.0),
          ),
        );
  }

  /// Delete a customer by String ID
  Future<int> deleteContact(String id) async {
    return await (_db.delete(_db.customers)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Update an existing customer
  Future<bool> updateContact(Customer customer) async {
    return await _db.update(_db.customers).replace(customer);
  }
}