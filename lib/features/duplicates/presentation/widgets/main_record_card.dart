// lib/features/duplicates/presentation/widgets/main_record_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class MainRecordCard extends StatelessWidget {
  final String name;
  final String company;
  final String position;
  final String email;
  final String phone;
  final String website;
  final String avatarUrl;

  const MainRecordCard({
    super.key,
    required this.name,
    required this.company,
    required this.position,
    required this.email,
    required this.phone,
    required this.website,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: AppColors.accentLime,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Profile Section
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.surfaceCard,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.headingLarge.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        company,
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        position,
                        style: AppTypography.labelBold.copyWith(
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // White Nested Details Container
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(AppSpacing.xs),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Main Record', style: AppTypography.headingMedium),
                      Row(
                        children: [
                          _IconButton(icon: Icons.edit_outlined, onTap: () {}),
                          const SizedBox(width: AppSpacing.xs),
                          _IconButton(icon: Icons.open_in_new_outlined, onTap: () {}),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  
                  // Contact Grid Pills
                  _DetailPill(icon: Icons.person_outline, label: 'Name', value: name),
                  _DetailPill(icon: Icons.work_outline, label: 'Position', value: position),
                  _DetailPill(icon: Icons.email_outlined, label: 'Email', value: email),
                  _DetailPill(icon: Icons.phone_outlined, label: 'Office Phone', value: phone),
                  _DetailPill(icon: Icons.language_outlined, label: 'Website', value: website),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailPill({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.textMuted),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTypography.bodySmall),
                  Text(
                    value,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xs + 2),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Icon(icon, size: 16, color: AppColors.textSecondary),
      ),
    );
  }
}