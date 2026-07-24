// lib/features/quotations/domain/quotation_model.dart

import 'quotation_item.dart';

enum QuotationStatus { draft, sent, accepted, rejected }

class QuotationModel {
  final int? id;
  final String quotationNumber;
  final int contactId;
  final String contactName;
  final String contactEmail;
  final List<QuotationItem> items;
  final double taxRate; // Percentage e.g. 0.08 for 8%
  final QuotationStatus status;
  final DateTime createdAt;
  final DateTime validUntil;

  const QuotationModel({
    this.id,
    required this.quotationNumber,
    required this.contactId,
    required this.contactName,
    required this.contactEmail,
    required this.items,
    this.taxRate = 0.0,
    required this.status,
    required this.createdAt,
    required this.validUntil,
  });

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get taxAmount => subtotal * taxRate;
  double get totalAmount => subtotal + taxAmount;

  QuotationModel copyWith({
    int? id,
    String? quotationNumber,
    int? contactId,
    String? contactName,
    String? contactEmail,
    List<QuotationItem>? items,
    double? taxRate,
    QuotationStatus? status,
    DateTime? createdAt,
    DateTime? validUntil,
  }) {
    return QuotationModel(
      id: id ?? this.id,
      quotationNumber: quotationNumber ?? this.quotationNumber,
      contactId: contactId ?? this.contactId,
      contactName: contactName ?? this.contactName,
      contactEmail: contactEmail ?? this.contactEmail,
      items: items ?? this.items,
      taxRate: taxRate ?? this.taxRate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      validUntil: validUntil ?? this.validUntil,
    );
  }
}