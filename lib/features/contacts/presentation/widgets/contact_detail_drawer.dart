// lib/features/contacts/presentation/widgets/contact_detail_drawer.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/customer_model.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/status_badge.dart';

class ContactDetailDrawer extends StatelessWidget {
  final CustomerModel contact;
  final VoidCallback onClose;
  final Function(CustomerModel) onDelete;

  const ContactDetailDrawer({
    super.key,
    required this.contact,
    required this.onClose,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfaceCard,
        border: Border(left: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Column(
        children: [
          // Header Bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Contact Details', style: AppTypography.headingMedium),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                  onPressed: onClose,
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.borderSubtle, height: 1),

          // Content Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Avatar & Name
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: AppColors.accentLime.withOpacity(0.15),
                          child: Text(
                            contact.firstName.isNotEmpty ? contact.firstName[0].toUpperCase() : '?',
                            style: AppTypography.displayMedium.copyWith(color: AppColors.accentLime),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(contact.fullName, style: AppTypography.headingLarge),
                        if (contact.position != null || contact.company != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '${contact.position ?? ""} ${contact.position != null && contact.company != null ? "at" : ""} ${contact.company ?? ""}',
                            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                          ),
                        ],
                        const SizedBox(height: AppSpacing.md),
                        StatusBadge(
                          label: contact.status,
                          color: contact.status == 'Won'
                              ? AppColors.success
                              : contact.status == 'Proposal'
                                  ? AppColors.warning
                                  : AppColors.accentBlue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const Divider(color: AppColors.borderSubtle),
                  const SizedBox(height: AppSpacing.lg),

                  // Information Fields
                  _buildInfoRow(Icons.email_outlined, 'Email', contact.email ?? '—'),
                  _buildInfoRow(Icons.phone_outlined, 'Phone', contact.phone ?? 'N/A'),
                  _buildInfoRow(
                    Icons.attach_money_rounded,
                    'Deal Value',
                    '\$${contact.dealValue.toStringAsFixed(2)}',
                  ),
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    'Added Date',
                    contact.createdAt != null
                        ? '${contact.createdAt!.day}/${contact.createdAt!.month}/${contact.createdAt!.year}'
                        : 'N/A',
                  ),
                ],
              ),
            ),
          ),

          // Action Footer
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                label: 'Delete Contact',
                variant: AppButtonVariant.secondary,
                icon: Icons.delete_outline_rounded,
                onPressed: () => onDelete(contact),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.textMuted),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted, fontSize: 11),
                ),
                Text(value, style: AppTypography.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}