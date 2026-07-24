// lib/features/quotations/presentation/widgets/quotation_builder_dialog.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/quotation_item.dart';
import '../../domain/quotation_model.dart';

class QuotationBuilderDialog extends StatefulWidget {
  final Function(QuotationModel) onSave;

  const QuotationBuilderDialog({super.key, required this.onSave});

  @override
  State<QuotationBuilderDialog> createState() => _QuotationBuilderDialogState();
}

class _QuotationBuilderDialogState extends State<QuotationBuilderDialog> {
  final _clientNameController = TextEditingController();
  final _clientEmailController = TextEditingController();
  final List<QuotationItem> _items = [];

  final _descController = TextEditingController();
  final _qtyController = TextEditingController(text: '1');
  final _priceController = TextEditingController();

  void _addItem() {
    final desc = _descController.text.trim();
    final qty = int.tryParse(_qtyController.text) ?? 1;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (desc.isNotEmpty && price > 0) {
      setState(() {
        _items.add(QuotationItem(
          id: 'item_${DateTime.now().millisecondsSinceEpoch}',
          description: desc,
          quantity: qty,
          unitPrice: price,
        ));
        _descController.clear();
        _qtyController.text = '1';
        _priceController.clear();
      });
    }
  }

  void _submit() {
    if (_clientNameController.text.isEmpty || _items.isEmpty) return;

    final quote = QuotationModel(
      quotationNumber: 'QT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      contactId: 1,
      contactName: _clientNameController.text,
      contactEmail: _clientEmailController.text,
      items: _items,
      taxRate: 0.10, // 10% tax rate default
      status: QuotationStatus.draft,
      createdAt: DateTime.now(),
      validUntil: DateTime.now().add(const Duration(days: 30)),
    );

    widget.onSave(quote);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Create New Quotation', style: AppTypography.headingLarge),
              const SizedBox(height: AppSpacing.lg),

              // Client details
              TextField(
                controller: _clientNameController,
                style: AppTypography.bodyMedium,
                decoration: const InputDecoration(labelText: 'Client Name'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _clientEmailController,
                style: AppTypography.bodyMedium,
                decoration: const InputDecoration(labelText: 'Client Email'),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Add Item Form
              Text('Line Items', style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _descController,
                      style: AppTypography.bodyMedium,
                      decoration: const InputDecoration(labelText: 'Description'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      style: AppTypography.bodyMedium,
                      decoration: const InputDecoration(labelText: 'Qty'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      style: AppTypography.bodyMedium,
                      decoration: const InputDecoration(labelText: 'Price (\$)'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add_circle, color: AppColors.accentLime),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Items List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(item.description, style: AppTypography.bodySmallBold),
                    subtitle: Text('${item.quantity} x \$${item.unitPrice}'),
                    trailing: Text('\$${item.totalPrice.toStringAsFixed(2)}', style: AppTypography.bodySmallBold),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  AppButton(
                    label: 'Save Quotation',
                    variant: AppButtonVariant.primary,
                    onPressed: _submit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}