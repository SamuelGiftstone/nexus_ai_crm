// lib/features/companies/presentation/companies_screen.dart

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/status_badge.dart';
import '../domain/models/company_model.dart';
import 'widgets/add_company_dialog.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatusFilter = 'All';
  String _selectedIndustryFilter = 'All';

  final List<CompanyModel> _companies = [
    CompanyModel(
      id: '1',
      name: 'Acme Inc.',
      domain: 'acme.io',
      industry: 'Manufacturing',
      contactCount: 3,
      status: 'Lead',
      revenue: '\$10M - \$50M',
    ),
    CompanyModel(
      id: '2',
      name: "L'Oréal",
      domain: 'loreal.com',
      industry: 'Cosmetics',
      contactCount: 2,
      status: 'Customer',
      revenue: '\$1M - \$10M',
    ),
    CompanyModel(
      id: '3',
      name: 'Gillette',
      domain: 'gillette.com',
      industry: 'Technology',
      contactCount: 5,
      status: 'Prospect',
      revenue: '\$50M - \$100M',
    ),
    CompanyModel(
      id: '4',
      name: "McDonald's",
      domain: 'mcdonalds.com',
      industry: 'Food',
      contactCount: 2,
      status: 'Customer',
      revenue: '\$1M - \$10M',
    ),
    CompanyModel(
      id: '5',
      name: 'Bank of America',
      domain: 'bofa.com',
      industry: 'Finance',
      contactCount: 3,
      status: 'Lead',
      revenue: '\$10M - \$50M',
    ),
    CompanyModel(
      id: '6',
      name: 'Pizza Hut',
      domain: 'pizzahut.com',
      industry: 'Food',
      contactCount: 7,
      status: 'Lead',
      revenue: '\$100M - \$500M',
    ),
    CompanyModel(
      id: '7',
      name: 'MasterCard',
      domain: 'mastercard.com',
      industry: 'Finance',
      contactCount: 4,
      status: 'Customer',
      revenue: '\$50M - \$100M',
    ),
    CompanyModel(
      id: '8',
      name: 'Sony',
      domain: 'sony.com',
      industry: 'IT Services',
      contactCount: 3,
      status: 'Customer',
      revenue: '\$10M - \$50M',
    ),
    CompanyModel(
      id: '9',
      name: 'Apple',
      domain: 'apple.com',
      industry: 'Manufacturing',
      contactCount: 5,
      status: 'Customer',
      revenue: '\$1M - \$10M',
    ),
    CompanyModel(
      id: '10',
      name: 'Louis Vuitton',
      domain: 'louisvuitton.com',
      industry: 'Software',
      contactCount: 2,
      status: 'Prospect',
      revenue: '\$50M - \$100M',
    ),
    CompanyModel(
      id: '11',
      name: 'General Electric',
      domain: 'ge.com',
      industry: 'Manufacturing',
      contactCount: 8,
      status: 'Prospect',
      revenue: '\$1M - \$10M',
    ),
    CompanyModel(
      id: '12',
      name: 'TechCorp',
      domain: 'techcorp.io',
      industry: 'Technology',
      contactCount: 4,
      status: 'Lead',
      revenue: '\$100M - \$500M',
    ),
    CompanyModel(
      id: '13',
      name: 'Mitsubishi',
      domain: 'mitsubishi.com',
      industry: 'Consulting',
      contactCount: 2,
      status: 'Prospect',
      revenue: '\$50M - \$100M',
    ),
    CompanyModel(
      id: '14',
      name: 'IBM',
      domain: 'ibm.com',
      industry: 'Manufacturing',
      contactCount: 5,
      status: 'Customer',
      revenue: '\$10M - \$20M',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _exportToPdf(List<CompanyModel> companies) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Companies Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Generated: ${DateTime.now().toLocal().toString().split(' ')[0]}', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              context: context,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey800),
              rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5))),
              cellAlignment: pw.Alignment.centerLeft,
              headers: ['Company Name', 'Domain', 'Industry', 'Revenue', 'Contacts', 'Status'],
              data: companies.map((c) => [
                c.name,
                c.domain,
                c.industry,
                c.revenue,
                c.contactCount.toString(),
                c.status,
              ]).toList(),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'companies_report.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCompanies = _companies.where((c) {
      final query = _searchController.text.toLowerCase();
      final matchesSearch = c.name.toLowerCase().contains(query) ||
          c.domain.toLowerCase().contains(query) ||
          c.industry.toLowerCase().contains(query);
      final matchesStatus = _selectedStatusFilter == 'All' || c.status == _selectedStatusFilter;
      final matchesIndustry = _selectedIndustryFilter == 'All' || c.industry == _selectedIndustryFilter;
      return matchesSearch && matchesStatus && matchesIndustry;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Section matching Desktop Layout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Companies', style: AppTypography.displayLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Manage company profiles and their associated contacts',
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AddCompanyDialog(
                            onCompanyAdded: (newCompany) {
                              setState(() {
                                _companies.insert(0, newCompany);
                              });
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Add Company'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.borderSubtle),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_downward_rounded, size: 16),
                      label: const Text('Import'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.borderSubtle),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => _exportToPdf(filteredCompanies),
                      icon: const Icon(Icons.arrow_upward_rounded, size: 16),
                      label: const Text('Export'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Toolbar Section: Lists, Search, Status Dropdown, Industries Dropdown, Advance Button
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
                      hintText: 'Search',
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
                  items: ['All', 'Lead', 'Customer', 'Prospect'],
                  onChanged: (val) => setState(() => _selectedStatusFilter = val!),
                ),
                const SizedBox(width: AppSpacing.sm),
                _buildDropdownFilter(
                  label: 'Industries',
                  value: _selectedIndustryFilter,
                  items: ['All', 'Manufacturing', 'Cosmetics', 'Technology', 'Food', 'Finance', 'IT Services', 'Software', 'Consulting'],
                  onChanged: (val) => setState(() => _selectedIndustryFilter = val!),
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

            // Main Desktop Data Table Container
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
                          Expanded(flex: 3, child: Text('Company', style: AppTypography.bodySmallBold)),
                          Expanded(flex: 2, child: Text('Industry', style: AppTypography.bodySmallBold)),
                          Expanded(flex: 3, child: Text('Domain', style: AppTypography.bodySmallBold)),
                          Expanded(flex: 2, child: Text('Revenue', style: AppTypography.bodySmallBold)),
                          Expanded(flex: 1, child: Text('Contacts', style: AppTypography.bodySmallBold)),
                          Expanded(flex: 2, child: Text('Status', style: AppTypography.bodySmallBold)),
                          const SizedBox(width: 40, child: Text('Actions', style: TextStyle(fontSize: 0))),
                        ],
                      ),
                    ),
                    // Table Rows
                    Expanded(
                      child: ListView.separated(
                        itemCount: filteredCompanies.length,
                        separatorBuilder: (_, __) => const Divider(color: AppColors.borderSubtle, height: 1),
                        itemBuilder: (context, index) {
                          final company = filteredCompanies[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                            child: Row(
                              children: [
                                const SizedBox(width: 24, child: Checkbox(value: false, onChanged: null)),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  flex: 3,
                                  child: Text(company.name, style: AppTypography.bodySmallBold),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(company.industry, style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(company.domain, style: AppTypography.bodySmall),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(company.revenue, style: AppTypography.bodySmall),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(company.contactCount.toString(), style: AppTypography.bodySmall),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: StatusBadge(
                                    label: company.status,
                                    color: company.status == 'Customer'
                                        ? AppColors.success
                                        : company.status == 'Prospect'
                                            ? AppColors.warning
                                            : AppColors.surfaceDark,
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: IconButton(
                                    icon: const Icon(Icons.more_horiz, size: 16),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
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
      ),
    );
  }

  Widget _buildDropdownFilter({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return documentDropdown(label, value, items, onChanged);
  }

  Widget documentDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
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