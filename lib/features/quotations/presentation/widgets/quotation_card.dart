// lib/features/quotations/presentation/widgets/quotation_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_card.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../../domain/quotation_model.dart';

class QuotationCard extends StatelessWidget {
  final QuotationModel quotation;
  final VoidCallback onTap;

  const QuotationCard({
    super.key,
    required this.quotation,
    required this.onTap,
  });

  Color _getStatusColor(QuotationStatus status) {
    switch (status) {
      case QuotationStatus.accepted:
        return AppColors.success;
      case QuotationStatus.sent:
        return AppColors.accentBlue;
      case QuotationStatus.rejected:
        return AppColors.error;
      case QuotationStatus.draft:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                quotation.quotationNumber,
                style: AppTypography.headingMedium.copyWith(color: AppColors.accentLime),
              ),
              StatusBadge(
                label: quotation.status.name.toUpperCase(),
                color: _getStatusColor(quotation.status),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            quotation.contactName,
            style: AppTypography.bodySmallBold,
          ),
          Text(
            quotation.contactEmail,
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.borderSubtle, height: 1),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${quotation.items.length} item(s)',
                style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
              ),
              Text(
                '\$${quotation.totalAmount.toStringAsFixed(2)}',
                style: AppTypography.headingMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}