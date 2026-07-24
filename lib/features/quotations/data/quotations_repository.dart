// lib/features/quotations/data/quotations_repository.dart

import 'package:drift/drift.dart';
import 'package:nexus_ai_crm/core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../domain/quotation_model.dart';

class QuotationsRepository {
  final AppDatabase _db;

  QuotationsRepository({AppDatabase? db})
      : _db = db ?? DatabaseProvider.instance {
    _seedInitialDataIfNeeded();
  }

  /// Seeds initial mockup records into Drift database if empty so PDF/UI lists have default data
  Future<void> _seedInitialDataIfNeeded() async {
    try {
      final countQuery = await _db.select(_db.quotations).get();
      if (countQuery.isEmpty) {
        final initialRows = [
          QuotationsCompanion(
            id: const Value('QT-2026-001'),
            customerId: const Value('1'),
            totalAmount: const Value(12500.00),
            status: const Value('approved'),
            createdAt: Value(DateTime.now().subtract(const Duration(days: 2))),
          ),
          QuotationsCompanion(
            id: const Value('QT-2026-002'),
            customerId: const Value('2'),
            totalAmount: const Value(4850.50),
            status: const Value('pending'),
            createdAt: Value(DateTime.now().subtract(const Duration(days: 4))),
          ),
          QuotationsCompanion(
            id: const Value('QT-2026-003'),
            customerId: const Value('3'),
            totalAmount: const Value(18900.00),
            status: const Value('draft'),
            createdAt: Value(DateTime.now().subtract(const Duration(days: 1))),
          ),
          QuotationsCompanion(
            id: const Value('QT-2026-004'),
            customerId: const Value('4'),
            totalAmount: const Value(7600.00),
            status: const Value('approved'),
            createdAt: Value(DateTime.now().subtract(const Duration(days: 5))),
          ),
          QuotationsCompanion(
            id: const Value('QT-2026-005'),
            customerId: const Value('5'),
            totalAmount: const Value(34200.00),
            status: const Value('pending'),
            createdAt: Value(DateTime.now().subtract(const Duration(days: 6))),
          ),
        ];

        for (var row in initialRows) {
          await _db.into(_db.quotations).insertOnConflictUpdate(row);
        }
      }
    } catch (_) {
      // Ignore seeding errors if table isn't fully initialized yet
    }
  }

  /// Fetches all stored quotations from local database
  Future<List<QuotationModel>> getQuotations() async {
    final rows = await _db.select(_db.quotations).get();

    return rows.map((row) {
      final parsedId = int.tryParse(row.id);
      final parsedContactId = int.tryParse(row.customerId) ?? 0;

      // Map mock contact names to match standard enterprise UI companies list if matching IDs
      const mockNames = {
        1: 'Acme Inc.',
        2: "L'Oréal",
        3: 'Gillette',
        4: "McDonald's",
        5: 'Bank of America',
      };

      final resolvedContactName = mockNames[parsedContactId] ?? 'Contact #$parsedContactId';

      return QuotationModel(
        id: parsedId,
        quotationNumber: row.id.startsWith('QT-') ? row.id : 'QT-${row.id}',
        contactId: parsedContactId,
        contactName: resolvedContactName,
        contactEmail: '',
        items: const [],
        validUntil: row.createdAt.add(const Duration(days: 30)),
        status: _parseStatus(row.status),
        createdAt: row.createdAt,
      );
    }).toList();
  }

  /// Inserts a new quotation or updates an existing record
  Future<int> saveQuotation(QuotationModel quote) async {
    final generatedId = quote.id ?? DateTime.now().millisecondsSinceEpoch;

    final companion = QuotationsCompanion(
      id: Value(quote.quotationNumber.isNotEmpty ? quote.quotationNumber : generatedId.toString()),
      customerId: Value(quote.contactId.toString()),
      totalAmount: Value(quote.totalAmount),
      status: Value(quote.status.name),
      createdAt: Value(quote.createdAt),
    );

    await _db.into(_db.quotations).insertOnConflictUpdate(companion);
    return generatedId;
  }

  /// Deletes a quotation by int primary ID
  Future<void> deleteQuotation(int id) async {
    await (_db.delete(_db.quotations)
          ..where((tbl) => tbl.id.equals(id.toString())))
        .go();
  }

  QuotationStatus _parseStatus(String statusStr) {
    try {
      return QuotationStatus.values.byName(statusStr.toLowerCase());
    } catch (_) {
      return QuotationStatus.draft;
    }
  }
}