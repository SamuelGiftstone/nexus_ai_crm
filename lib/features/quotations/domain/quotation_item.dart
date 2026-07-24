// lib/features/quotations/domain/quotation_item.dart

class QuotationItem {
  final String id;
  final String description;
  final int quantity;
  final double unitPrice;

  const QuotationItem({
    required this.id,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => quantity * unitPrice;

  QuotationItem copyWith({
    String? id,
    String? description,
    int? quantity,
    double? unitPrice,
  }) {
    return QuotationItem(
      id: id ?? this.id,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'quantity': quantity,
        'unitPrice': unitPrice,
      };

  factory QuotationItem.fromJson(Map<String, dynamic> json) => QuotationItem(
        id: json['id'] as String,
        description: json['description'] as String,
        quantity: json['quantity'] as int,
        unitPrice: (json['unitPrice'] as num).toDouble(),
      );
}