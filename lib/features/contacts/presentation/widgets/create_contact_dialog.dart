// lib/features/contacts/presentation/widgets/create_contact_dialog.dart

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/contacts_repository.dart';

class CreateContactDialog extends StatefulWidget {
  final ContactsRepository repository;
  final VoidCallback onContactCreated;

  const CreateContactDialog({
    super.key,
    required this.repository,
    required this.onContactCreated,
  });

  @override
  State<CreateContactDialog> createState() => _CreateContactDialogState();
}

class _CreateContactDialogState extends State<CreateContactDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  
  String _status = 'lead';
  double _dealValue = 0.0;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final newId = const Uuid().v4();
        await widget.repository.addContact(
          id: newId,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null,
          company: _companyController.text.trim().isNotEmpty ? _companyController.text.trim() : null,
          status: _status,
          dealValue: _dealValue,
        );
        widget.onContactCreated();
        if (mounted) Navigator.of(context).pop();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating contact: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      title: Text('Create Contact', style: AppTypography.displayLarge),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        style: AppTypography.bodySmall,
                        decoration: _inputDecoration('First Name *'),
                        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        style: AppTypography.bodySmall,
                        decoration: _inputDecoration('Last Name *'),
                        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _emailController,
                  style: AppTypography.bodySmall,
                  decoration: _inputDecoration('Email *'),
                  validator: (value) => value == null || !value.contains('@') ? 'Valid email required' : null,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _phoneController,
                  style: AppTypography.bodySmall,
                  decoration: _inputDecoration('Phone No'),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _companyController,
                  style: AppTypography.bodySmall,
                  decoration: _inputDecoration('Company'),
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<String>(
                  value: _status,
                  dropdownColor: AppColors.surfaceCard,
                  style: AppTypography.bodySmall,
                  decoration: _inputDecoration('Status'),
                  items: const [
                    DropdownMenuItem(value: 'lead', child: Text('Lead')),
                    DropdownMenuItem(value: 'Open Deal', child: Text('Open Deal')),
                    DropdownMenuItem(value: 'Negotiation', child: Text('Negotiation')),
                    DropdownMenuItem(value: 'Customer', child: Text('Customer')),
                  ],
                  onChanged: (val) => setState(() => _status = val ?? 'lead'),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textPrimary,
            foregroundColor: AppColors.background,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Save Contact'),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
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
    );
  }
}