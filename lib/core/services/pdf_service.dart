// lib/core/services/pdf_service.dart

import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfInvoiceItem {
  final String description;
  final int quantity;
  final double unitPrice;

  PdfInvoiceItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => quantity * unitPrice;
}

class PdfDocumentData {
  final String documentNumber;
  final DateTime date;
  final String companyName;
  final String companyEmail;
  final String customerName;
  final String customerEmail;
  final String currencySymbol;
  final double taxRate;
  final List<PdfInvoiceItem> items;

  PdfDocumentData({
    required this.documentNumber,
    required this.date,
    required this.companyName,
    required this.companyEmail,
    required this.customerName,
    required this.customerEmail,
    required this.items,
    this.currencySymbol = '\$',
    this.taxRate = 0.10,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get taxAmount => subtotal * taxRate;
  double get grandTotal => subtotal + taxAmount;
}

class PdfService {
  /// Generates document PDF raw bytes
  static Future<Uint8List> generateDocument(PdfDocumentData data) async {
    final pdf = pw.Document();

    final primaryColor = PdfColor.fromHex('#10B981'); // Brand Accent Lime / Green
    final darkBg = PdfColor.fromHex('#0F172A');
    final textColor = PdfColor.fromHex('#1E293B');
    final textMuted = PdfColor.fromHex('#64748B');
    final lightBg = PdfColor.fromHex('#F8FAFC');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Row
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        data.companyName,
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          color: darkBg,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        data.companyEmail,
                        style: pw.TextStyle(fontSize: 10, color: textMuted),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'QUOTATION / INVOICE',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        '#${data.documentNumber}',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                          color: darkBg,
                        ),
                      ),
                      pw.Text(
                        'Date: ${data.date.day}/${data.date.month}/${data.date.year}',
                        style: pw.TextStyle(fontSize: 9, color: textMuted),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 24),

              // Customer Details Card
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: lightBg,
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'BILLED TO',
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                        color: textMuted,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      data.customerName,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: darkBg,
                      ),
                    ),
                    pw.Text(
                      data.customerEmail,
                      style: pw.TextStyle(fontSize: 10, color: textMuted),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),

              // Items Table
              pw.TableHelper.fromTextArray(
                border: null,
                headerDecoration: pw.BoxDecoration(
                  color: darkBg,
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                headerHeight: 28,
                cellHeight: 28,
                headerStyle: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
                cellStyle: pw.TextStyle(color: textColor, fontSize: 10),
                headers: ['Description', 'Qty', 'Unit Price', 'Total'],
                data: data.items.map((item) {
                  return [
                    item.description,
                    item.quantity.toString(),
                    '${data.currencySymbol}${item.unitPrice.toStringAsFixed(2)}',
                    '${data.currencySymbol}${item.totalPrice.toStringAsFixed(2)}',
                  ];
                }).toList(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(4),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(2),
                },
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.center,
                  2: pw.Alignment.centerRight,
                  3: pw.Alignment.centerRight,
                },
              ),
              pw.Divider(color: PdfColors.grey300, thickness: 0.5),
              pw.SizedBox(height: 12),

              // Totals Calculation
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.SizedBox(
                    width: 200,
                    child: pw.Column(
                      children: [
                        _buildSummaryRow(
                          'Subtotal:',
                          '${data.currencySymbol}${data.subtotal.toStringAsFixed(2)}',
                          textColor,
                        ),
                        pw.SizedBox(height: 4),
                        _buildSummaryRow(
                          'Tax (${(data.taxRate * 100).toStringAsFixed(0)}%):',
                          '${data.currencySymbol}${data.taxAmount.toStringAsFixed(2)}',
                          textColor,
                        ),
                        pw.Divider(color: PdfColors.grey300, thickness: 0.5),
                        _buildSummaryRow(
                          'Grand Total:',
                          '${data.currencySymbol}${data.grandTotal.toStringAsFixed(2)}',
                          primaryColor,
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.Spacer(),

              // Footer Note
              pw.Center(
                child: pw.Text(
                  'Thank you for your business!',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: textMuted,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  /// Direct trigger to preview or print the document
  static Future<void> printOrExport(PdfDocumentData data) async {
    final bytes = await generateDocument(data);
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
      name: '${data.documentNumber}.pdf',
    );
  }

  static pw.Widget _buildSummaryRow(
    String label,
    String value,
    PdfColor color, {
    bool isBold = false,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: isBold ? 11 : 10,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: color,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: isBold ? 11 : 10,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: color,
          ),
        ),
      ],
    );
  }
}