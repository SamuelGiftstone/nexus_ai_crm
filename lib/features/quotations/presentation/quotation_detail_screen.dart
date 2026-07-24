// lib/features/quotations/presentation/quotation_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/quotation_model.dart';

class QuotationDetailScreen extends StatefulWidget {
  final QuotationModel quotation;

  const QuotationDetailScreen({
    super.key,
    required this.quotation,
  });

  @override
  State<QuotationDetailScreen> createState() => _QuotationDetailScreenState();
}

class _QuotationDetailScreenState extends State<QuotationDetailScreen> {
  bool _showComments = true;
  final TextEditingController _commentController = TextEditingController();
  late List<QuotationItemModel> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.quotation.items.map((item) => QuotationItemModel(
      itemName: item.description,
      status: '-',
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      estimatedDeliveryDate: '-',
      isSelected: true,
    )).toList();
    if (_items.isNotEmpty) {
      _items[0] = QuotationItemModel(
        itemName: _items[0].itemName,
        status: _items[0].status,
        quantity: _items[0].quantity,
        unitPrice: _items[0].unitPrice,
        estimatedDeliveryDate: 'Dec 17, 2021',
        isSelected: _items[0].isSelected,
      );
    }
  }

  final List<Map<String, String>> _comments = [
    {
      'author': 'Jacob',
      'time': 'Oct 21 at 18:00',
      'text':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (pw.Context context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Quotation ${widget.quotation.quotationNumber}', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 4),
                    pw.Text('Valid Until: ${widget.quotation.validUntil.toLocal().toString().split(' ')[0]}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Salesperson: Biance Lee', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    pw.Text('biancal@blurmark.com', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Divider(color: PdfColors.grey400),
            pw.SizedBox(height: 8),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Delivery Address:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    pw.Text(widget.quotation.contactName, style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('27909 Hancock Pkwy\nValencia, California 91355', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Point of Contact: Ship', style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.orange800),
              rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5))),
              cellStyle: const pw.TextStyle(fontSize: 10),
              cellAlignment: pw.Alignment.centerLeft,
              headers: ['Item', 'Status', 'Qty', 'Unit Price', 'Subtotal', 'Est. Delivery'],
              data: _items.where((i) => i.isSelected).map((item) => [
                item.itemName,
                item.status,
                item.quantity.toString(),
                '\$${item.unitPrice.toStringAsFixed(2)}',
                '\$${item.subtotal.toStringAsFixed(0)}',
                item.estimatedDeliveryDate,
              ]).toList(),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  void _showPdfPreviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderSubtle),
        ),
        child: SizedBox(
          width: 900,
          height: 700,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quotation PDF Preview', style: AppTypography.displayMedium),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18, color: AppColors.textMuted),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.borderSubtle),
              Expanded(
                child: PdfPreview(
                  build: (format) => _generatePdf(format),
                  allowPrinting: true,
                  allowSharing: true,
                  canChangePageFormat: false,
                  canChangeOrientation: false,
                  initialPageFormat: PdfPageFormat.a4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Current Quotation', style: AppTypography.displayLarge),
                InkWell(
                  onTap: () => _showPdfPreviewDialog(context),
                  child: Row(
                    children: [
                      const Icon(Icons.visibility_rounded, size: 16, color: Colors.blue),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'View Quotation PDF',
                        style: AppTypography.bodySmallBold.copyWith(color: Colors.blue),
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Icon(Icons.refresh_rounded, size: 16, color: Colors.blue),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              'View Quotation History',
                              style: AppTypography.bodySmallBold.copyWith(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Quotation Details Card
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.quotation.quotationNumber, style: AppTypography.bodyMedium),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              _items.isNotEmpty ? _items.first.itemName : '',
                              style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Valid Through', style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                            const SizedBox(height: AppSpacing.xs),
                            Text(widget.quotation.validUntil.toLocal().toString().split(' ')[0], style: AppTypography.bodySmallBold),
                            const SizedBox(height: AppSpacing.md),
                            Text('Delivery Address', style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                            const SizedBox(height: AppSpacing.xs),
                            Text(widget.quotation.contactName, style: AppTypography.bodySmallBold),
                            Text('27909 Hancock Pkwy\nValencia, California 91355', style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Point of contact', style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                            const SizedBox(height: AppSpacing.xs),
                            Text('Ship', style: AppTypography.bodySmall),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'Send Message',
                                style: AppTypography.bodySmall.copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text('Salesperson', style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                            const SizedBox(height: AppSpacing.xs),
                            Text('Biance Lee', style: AppTypography.bodySmallBold),
                            Text(
                              'biancal@blurmark.com',
                              style: AppTypography.bodySmall.copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const Divider(color: AppColors.borderSubtle),
                  const SizedBox(height: AppSpacing.md),

                  // Table Header
                  Row(
                    children: [
                      Expanded(flex: 3, child: Text('Item', style: AppTypography.bodySmallBold)),
                      Expanded(flex: 1, child: Text('Status', style: AppTypography.bodySmallBold)),
                      Expanded(flex: 1, child: Text('Quantity', style: AppTypography.bodySmallBold)),
                      Expanded(flex: 1, child: Text('Unit Price', style: AppTypography.bodySmallBold)),
                      Expanded(flex: 1, child: Text('Sub total', style: AppTypography.bodySmallBold)),
                      Expanded(flex: 2, child: Text('Estimated Delivery Date', style: AppTypography.bodySmallBold)),
                      const SizedBox(width: 60, child: Text('Select', style: AppTypography.bodySmallBold)),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Divider(color: AppColors.borderSubtle),

                  // Table Items
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const Divider(color: AppColors.borderSubtle, height: 1),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text(item.itemName, style: AppTypography.bodySmallBold)),
                            Expanded(flex: 1, child: Text(item.status, style: AppTypography.bodySmall)),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Text('${item.quantity} Qty', style: AppTypography.bodySmall),
                                  const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: AppColors.textMuted),
                                ],
                              ),
                            ),
                            Expanded(flex: 1, child: Text('\$${item.unitPrice.toStringAsFixed(2)}', style: AppTypography.bodySmall)),
                            Expanded(flex: 1, child: Text('\$${item.subtotal.toStringAsFixed(0)}', style: AppTypography.bodySmall)),
                            Expanded(flex: 2, child: Text(item.estimatedDeliveryDate, style: AppTypography.bodySmall)),
                            SizedBox(
                              width: 60,
                              child: Switch(
                                value: item.isSelected,
                                activeColor: Colors.teal,
                                onChanged: (val) {
                                  setState(() {
                                    item.isSelected = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: IconButton(
                                icon: const Icon(Icons.more_vert, size: 16, color: AppColors.textMuted),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Bottom Actions & Comments Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _showComments = !_showComments;
                    });
                  },
                  child: Row(
                    children: [
                      Text('View Comments', style: AppTypography.bodyMedium.copyWith(color: Colors.blue)),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(_showComments ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 16, color: Colors.blue),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: AppColors.surfaceDark, shape: BoxShape.circle),
                        child: Text(_comments.length.toString(), style: AppTypography.bodySmallBold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        side: const BorderSide(color: Colors.orange),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                      ),
                      onPressed: () {},
                      child: const Text('REQUEST A CHANGE'),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                      ),
                      onPressed: () {},
                      child: const Text('ACCEPT QUOTE'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            if (_showComments) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            style: AppTypography.bodySmall,
                            decoration: InputDecoration(
                              hintText: 'Drop Your Comments',
                              hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                              filled: true,
                              fillColor: AppColors.surfaceDark,
                              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderSubtle),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: AppColors.borderSubtle),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            if (_commentController.text.trim().isNotEmpty) {
                              setState(() {
                                _comments.add({
                                  'author': 'You',
                                  'time': 'Just now',
                                  'text': _commentController.text.trim(),
                                });
                                _commentController.clear();
                              });
                            }
                          },
                          child: const Text('Send'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Divider(color: AppColors.borderSubtle),
                    const SizedBox(height: AppSpacing.lg),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _comments.length,
                      separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.symmetric(vertical: AppSpacing.md), child: Divider(color: AppColors.borderSubtle)),
                      itemBuilder: (context, index) {
                        final comment = _comments[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(comment['author']!, style: AppTypography.bodySmallBold),
                                Text(comment['time']!, style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(comment['text']!, style: AppTypography.bodySmall),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class QuotationItemModel {
  final String itemName;
  final String status;
  final int quantity;
  final double unitPrice;
  final String estimatedDeliveryDate;
  bool isSelected;

  QuotationItemModel({
    required this.itemName,
    required this.status,
    required this.quantity,
    required this.unitPrice,
    required this.estimatedDeliveryDate,
    this.isSelected = true,
  });

  double get subtotal => quantity * unitPrice;
}