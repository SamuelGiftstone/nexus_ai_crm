// lib/features/quotations/presentation/quotations_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/status_badge.dart';
import '../data/quotations_repository.dart';
import '../domain/quotation_model.dart';
import 'quotation_detail_screen.dart';
import 'widgets/quotation_builder_dialog.dart';

class QuotationsScreen extends StatefulWidget {
  const QuotationsScreen({super.key});

  @override
  State<QuotationsScreen> createState() => _QuotationsScreenState();
}

class _QuotationsScreenState extends State<QuotationsScreen> {
  final QuotationsRepository _repository = QuotationsRepository();
  late Future<List<QuotationModel>> _quotationsFuture;
  
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatusFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadQuotations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadQuotations() {
    setState(() {
      _quotationsFuture = _repository.getQuotations();
    });
  }

  void _openBuilderDialog() {
    showDialog(
      context: context,
      builder: (context) => QuotationBuilderDialog(
        onSave: (quote) async {
          await _repository.saveQuotation(quote);
          _loadQuotations();
        },
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, List<QuotationModel> quotations) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Quotations List Report', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Generated: ${DateTime.now().toLocal().toString().split(' ')[0]}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                ],
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white, fontSize: 10),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey800),
              rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5))),
              cellStyle: const pw.TextStyle(fontSize: 10),
              cellAlignment: pw.Alignment.centerLeft,
              headers: ['Quote #', 'Client', 'Valid Until', 'Status', 'Total Amount'],
              data: quotations.map((q) => [
                q.quotationNumber,
                q.contactName,
                q.validUntil.toLocal().toString().split(' ')[0],
                q.status.name.toUpperCase(),
                '\$${q.totalAmount.toStringAsFixed(2)}',
              ]).toList(),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  void _showPdfPreviewDialog(BuildContext context, List<QuotationModel> quotations) {
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
                    Text('Quotations PDF Preview', style: AppTypography.displayMedium),
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
                  build: (format) => _generatePdf(format, quotations),
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
      body: FutureBuilder<List<QuotationModel>>(
        future: _quotationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.textPrimary,
              ),
            );
          }

          final quotes = snapshot.data ?? [];
          final query = _searchController.text.toLowerCase();
          
          final filteredQuotes = quotes.where((q) {
            final matchesSearch = q.quotationNumber.toLowerCase().contains(query) ||
                q.contactName.toLowerCase().contains(query);
            final matchesStatus = _selectedStatusFilter == 'All' || 
                q.status.name.toUpperCase() == _selectedStatusFilter.toUpperCase();
            return matchesSearch && matchesStatus;
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Header Section (Matching CompaniesScreen structure)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quotations', style: AppTypography.displayLarge),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Manage customer quotations, items, and billing status',
                          style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textPrimary,
                            foregroundColor: AppColors.background,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: _openBuilderDialog,
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('New Quotation'),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(color: AppColors.borderSubtle),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: quotes.isEmpty ? null : () => _showPdfPreviewDialog(context, filteredQuotes),
                          icon: const Icon(Icons.picture_as_pdf_rounded, size: 16),
                          label: const Text('View PDF'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // 2. Toolbar Section: Search and Filters (Matching CompaniesScreen layout)
                Row(
                  children: [
                    Text('Lists', style: AppTypography.bodyMedium),
                    const SizedBox(width: AppSpacing.lg),
                    SizedBox(
                      width: 240,
                      height: 38,
                      child: TextField(
                        controller: _searchController,
                        style: AppTypography.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'Search quotation or client',
                          hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                          prefixIcon: const Icon(Icons.search_rounded, size: 16, color: AppColors.textMuted),
                          filled: true,
                          fillColor: AppColors.surfaceCard,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.borderSubtle),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.borderSubtle),
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _buildDropdownFilter(
                      label: 'Status',
                      value: _selectedStatusFilter,
                      items: const ['All', 'Draft', 'Pending', 'Approved', 'Rejected'],
                      onChanged: (val) => setState(() => _selectedStatusFilter = val!),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.borderSubtle),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.tune_rounded, size: 16),
                      label: const Text('Advance'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // 3. Main Desktop Data Table Container (Matching CompaniesScreen Table Grid)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Column(
                      children: [
                        // Table Header Row
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 24, child: Checkbox(value: false, onChanged: null)),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(flex: 2, child: Text('Quote #', style: AppTypography.bodySmallBold)),
                              Expanded(flex: 3, child: Text('Client Name', style: AppTypography.bodySmallBold)),
                              Expanded(flex: 2, child: Text('Valid Until', style: AppTypography.bodySmallBold)),
                              Expanded(flex: 2, child: Text('Total Amount', style: AppTypography.bodySmallBold)),
                              Expanded(flex: 2, child: Text('Status', style: AppTypography.bodySmallBold)),
                              const SizedBox(width: 40, child: Text('Actions', style: TextStyle(fontSize: 0))),
                            ],
                          ),
                        ),
                        // Table Rows
                        Expanded(
                          child: filteredQuotes.isEmpty
                              ? Center(
                                  child: Text(
                                    'No quotations found',
                                    style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: filteredQuotes.length,
                                  separatorBuilder: (_, __) => const Divider(color: AppColors.borderSubtle, height: 1),
                                  itemBuilder: (context, index) {
                                    final quotation = filteredQuotes[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => QuotationDetailScreen(quotation: quotation),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 24, child: Checkbox(value: false, onChanged: null)),
                                            const SizedBox(width: AppSpacing.md),
                                            Expanded(
                                              flex: 2,
                                              child: Text(quotation.quotationNumber, style: AppTypography.bodySmallBold),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(quotation.contactName, style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(quotation.validUntil.toLocal().toString().split(' ')[0], style: AppTypography.bodySmall),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text('\$${quotation.totalAmount.toStringAsFixed(2)}', style: AppTypography.bodySmallBold),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: StatusBadge(
                                                label: quotation.status.name.toUpperCase(),
                                                color: quotation.status.name == 'approved'
                                                    ? AppColors.success
                                                    : quotation.status.name == 'pending'
                                                        ? AppColors.warning
                                                        : AppColors.surfaceDark,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                              child: IconButton(
                                                icon: const Icon(Icons.more_horiz, size: 16),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => QuotationDetailScreen(quotation: quotation),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        // Footer Pagination Bar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                          decoration: const BoxDecoration(
                            border: Border(top: BorderSide(color: AppColors.borderSubtle)),
                          ),
                          child: Row(
                            children: [
                              Text('View', style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                              const SizedBox(width: AppSpacing.xs),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.borderSubtle),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text('10', style: AppTypography.bodySmall),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text('lists per page', style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text('< Previous', style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text('1  2  3  ...  8  9  10', style: AppTypography.bodySmall),
                              const SizedBox(width: AppSpacing.sm),
                              TextButton(
                                onPressed: () {},
                                child: Text('Next >', style: AppTypography.bodySmall),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdownFilter({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.surfaceCard,
          style: AppTypography.bodySmall,
          icon: const Padding(
            padding: EdgeInsets.only(left: AppSpacing.xs),
            child: Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: AppColors.textMuted),
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item == 'All' ? label : item),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}