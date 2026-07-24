// lib/features/companies/presentation/widgets/add_company_dialog.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/company_model.dart';

class AddCompanyDialog extends StatefulWidget {
  final ValueChanged<CompanyModel> onCompanyAdded;

  const AddCompanyDialog({
    super.key,
    required this.onCompanyAdded,
  });

  @override
  State<AddCompanyDialog> createState() => _AddCompanyDialogState();
}

class _AddCompanyDialogState extends State<AddCompanyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _domainController = TextEditingController();
  
  String _industry = 'Technology';
  String _status = 'Lead';
  String _revenue = '\$1M - \$10M';
  final int _contactCount = 1;

  @override
  void dispose() {
    _nameController.dispose();
    _domainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Company', style: AppTypography.displayMedium),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16, color: AppColors.textMuted),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Company Name', style: AppTypography.bodySmallBold),
              const SizedBox(height: AppSpacing.xs),
              TextFormField(
                controller: _nameController,
                style: AppTypography.bodySmall,
                decoration: _inputDecoration('e.g. Acme Corp'),
                validator: (val) => val == null || val.isEmpty ? 'Please enter a company name' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Domain', style: AppTypography.bodySmallBold),
              const SizedBox(height: AppSpacing.xs),
              TextFormField(
                controller: _domainController,
                style: AppTypography.bodySmall,
                decoration: _inputDecoration('e.g. acme.io'),
                validator: (val) => val == null || val.isEmpty ? 'Please enter a domain' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Industry', style: AppTypography.bodySmallBold),
                        const SizedBox(height: AppSpacing.xs),
                        DropdownButtonFormField<String>(
                          value: _industry,
                          dropdownColor: AppColors.surfaceCard,
                          style: AppTypography.bodySmall,
                          decoration: _inputDecoration(''),
                          items: ['Manufacturing', 'Cosmetics', 'Technology', 'Food', 'Finance', 'IT Services', 'Software', 'Consulting']
                              .map((ind) => DropdownMenuItem(value: ind, child: Text(ind)))
                              .toList(),
                          onChanged: (val) => setState(() => _industry = val!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status', style: AppTypography.bodySmallBold),
                        const SizedBox(height: AppSpacing.xs),
                        DropdownButtonFormField<String>(
                          value: _status,
                          dropdownColor: AppColors.surfaceCard,
                          style: AppTypography.bodySmall,
                          decoration: _inputDecoration(''),
                          items: ['Lead', 'Customer', 'Prospect']
                              .map((st) => DropdownMenuItem(value: st, child: Text(st)))
                              .toList(),
                          onChanged: (val) => setState(() => _status = val!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Revenue', style: AppTypography.bodySmallBold),
              const SizedBox(height: AppSpacing.xs),
              DropdownButtonFormField<String>(
                value: _revenue,
                dropdownColor: AppColors.surfaceCard,
                style: AppTypography.bodySmall,
                decoration: _inputDecoration(''),
                items: ['\$1M - \$10M', '\$10M - \$50M', '\$50M - \$100M', '\$100M - \$500M']
                    .map((rev) => DropdownMenuItem(value: rev, child: Text(rev)))
                    .toList(),
                onChanged: (val) => setState(() => _revenue = val!),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.borderSubtle),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textPrimary,
                      foregroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newCompany = CompanyModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _nameController.text.trim(),
                          domain: _domainController.text.trim(),
                          industry: _industry,
                          contactCount: _contactCount,
                          status: _status,
                          revenue: _revenue,
                        );
                        widget.onCompanyAdded(newCompany);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save Company'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
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
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.textPrimary),
      ),
    );
  }
}