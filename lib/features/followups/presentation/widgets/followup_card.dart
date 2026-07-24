// lib/features/followups/presentation/widgets/followup_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_card.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../../domain/followup_model.dart';

class FollowupCard extends StatelessWidget {
  final FollowupModel followup;
  final VoidCallback onComplete;
  final VoidCallback onTap;

  const FollowupCard({
    super.key,
    required this.followup,
    required this.onComplete,
    required this.onTap,
  });

  IconData _getTypeIcon(FollowupType type) {
    switch (type) {
      case FollowupType.email:
        return Icons.email_outlined;
      case FollowupType.call:
        return Icons.phone_outlined;
      case FollowupType.meeting:
        return Icons.calendar_today_outlined;
      case FollowupType.task:
        return Icons.check_box_outlined;
    }
  }

  Color _getPriorityColor(FollowupPriority priority) {
    switch (priority) {
      case FollowupPriority.urgent:
        return AppColors.error;
      case FollowupPriority.high:
        return Colors.orangeAccent;
      case FollowupPriority.medium:
        return AppColors.accentBlue;
      case FollowupPriority.low:
        return AppColors.textMuted;
    }
  }

  Color _getStatusColor(FollowupStatus status) {
    switch (status) {
      case FollowupStatus.completed:
        return AppColors.success;
      case FollowupStatus.overdue:
        return AppColors.error;
      case FollowupStatus.pending:
        return AppColors.accentLime;
      case FollowupStatus.cancelled:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDone = followup.status == FollowupStatus.completed;

    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: _getPriorityColor(followup.priority).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getTypeIcon(followup.type),
                  color: _getPriorityColor(followup.priority),
                  size: 18,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      followup.title,
                      style: AppTypography.bodySmallBold.copyWith(
                        decoration: isDone ? TextDecoration.lineThrough : null,
                        color: isDone ? AppColors.textMuted : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      followup.contactName,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: followup.status.name.toUpperCase(),
                color: _getStatusColor(followup.status),
              ),
            ],
          ),
          if (followup.note != null && followup.note!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              followup.note!,
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.borderSubtle, height: 1),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: AppColors.textMuted),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '${followup.scheduledAt.month}/${followup.scheduledAt.day}/${followup.scheduledAt.year}',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
              if (!isDone)
                IconButton(
                  onPressed: onComplete,
                  icon: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.accentLime,
                  ),
                  tooltip: 'Mark Completed',
                ),
            ],
          ),
        ],
      ),
    );
  }
}