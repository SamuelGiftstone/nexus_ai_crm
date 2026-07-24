// lib/features/duplicates/data/duplicates_repository.dart

import 'package:drift/drift.dart';
import 'package:nexus_ai_crm/core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../shared/models/customer_model.dart';
import '../domain/duplicate_cluster.dart';

class DuplicatesRepository {
  final AppDatabase _db;

  DuplicatesRepository({AppDatabase? db})
      : _db = db ?? DatabaseProvider.instance;

  /// Scans database to detect duplicate contact clusters
  Future<List<DuplicateCluster>> findDuplicates() async {
    final rows = await _db.select(_db.customers).get();

    final contacts = rows.map((row) {
      return CustomerModel(
        id: row.id,
        firstName: row.firstName,
        lastName: row.lastName,
        company: row.company,
        position: row.position,
        email: row.email,
        phone: row.phone,
        dealValue: row.dealValue ?? 0.0,
        status: row.status ?? 'Lead',
        createdAt: row.createdAt,
      );
    }).toList();

    final List<DuplicateCluster> clusters = [];
    final Set<int> processedIds = {};

    for (int i = 0; i < contacts.length; i++) {
      final current = contacts[i];
      if (current.id != null && processedIds.contains(current.id)) continue;

      final List<CustomerModel> candidates = [];
      DuplicateMatchType matchType = DuplicateMatchType.exactEmail;
      double maxConfidence = 0.0;

      for (int j = i + 1; j < contacts.length; j++) {
        final target = contacts[j];
        if (target.id != null && processedIds.contains(target.id)) continue;

        // Rule 1: Exact Email Match
        if (current.email != null &&
            current.email!.isNotEmpty &&
            target.email != null &&
            current.email!.trim().toLowerCase() == target.email!.trim().toLowerCase()) {
          candidates.add(target);
          matchType = DuplicateMatchType.exactEmail;
          maxConfidence = 0.98;
        }
        // Rule 2: Phone Match
        else if (current.phone != null &&
            current.phone!.isNotEmpty &&
            current.phone == target.phone) {
          candidates.add(target);
          matchType = DuplicateMatchType.matchingPhone;
          maxConfidence = 0.90;
        }
        // Rule 3: Fuzzy Name & Company Match
        else if (_isFuzzyMatch(current, target)) {
          candidates.add(target);
          matchType = DuplicateMatchType.fuzzyNameAndCompany;
          maxConfidence = 0.85;
        }
      }

      if (candidates.isNotEmpty && current.id != null) {
        processedIds.add(current.id as int);
        for (var c in candidates) {
          if (c.id != null) processedIds.add(c.id as int);
        }

        clusters.add(DuplicateCluster(
          id: 'cluster_${current.id}',
          primaryContact: current,
          duplicateCandidates: candidates,
          matchType: matchType,
          confidenceScore: maxConfidence,
        ));
      }
    }

    return clusters;
  }

  /// Merges primary and candidate contacts into single record
  Future<void> mergeContacts({
    required CustomerModel mergedContact,
    required List<int> idsToDelete,
  }) async {
    // 1. Update Primary Record
    final companion = CustomersCompanion(
      id: Value(mergedContact.id!),
      firstName: Value(mergedContact.firstName),
      lastName: Value(mergedContact.lastName),
      company: Value(mergedContact.company),
      position: Value(mergedContact.position),
      email: Value(mergedContact.email),
      phone: Value(mergedContact.phone),
      dealValue: Value(mergedContact.dealValue),
      status: Value(mergedContact.status),
    );

    await _db.into(_db.customers).insertOnConflictUpdate(companion);

    // 2. Delete redundant candidate records
    for (final id in idsToDelete) {
      await (_db.delete(_db.customers)..where((t) => t.id.equals(id.toString()))).go();
    }
  }

  bool _isFuzzyMatch(CustomerModel a, CustomerModel b) {
    final nameA = '${a.firstName} ${a.lastName}'.trim().toLowerCase();
    final nameB = '${b.firstName} ${b.lastName}'.trim().toLowerCase();

    if (nameA == nameB && nameA.isNotEmpty) return true;

    if (a.company != null &&
        b.company != null &&
        a.company!.toLowerCase() == b.company!.toLowerCase() &&
        a.firstName.toLowerCase() == b.firstName.toLowerCase()) {
      return true;
    }

    return false;
  }
}