// lib/features/copilot/presentation/widgets/quick_action_grid.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class QuickActionItem {
  final String title;
  final String description;
  final IconData icon;
  final String prompt;

  const QuickActionItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.prompt,
  });
}

class QuickActionGrid extends StatelessWidget {
  final Function(String) onActionSelected;

  const QuickActionGrid({
    super.key,
    required this.onActionSelected,
  });

  static const List<QuickActionItem> _actions = [
    QuickActionItem(
      title: 'Analyze Pipeline',
      description: 'Get deal breakdown, velocity, and revenue risks',
      icon: Icons.analytics_outlined,
      prompt: 'Analyze my current pipeline and deal status',
    ),
    QuickActionItem(
      title: 'Find Stale Leads',
      description: 'Locate contacts with no recent activity or touchpoints',
      icon: Icons.person_search_outlined,
      prompt: 'Show me inactive or stale leads needing follow-up',
    ),
    QuickActionItem(
      title: 'Scan Duplicates',
      description: 'Run automatic deduplication on SQLite records',
      icon: Icons.find_in_page_outlined,
      prompt: 'Scan database for duplicate contacts and emails',
    ),
    QuickActionItem(
      title: 'Draft Campaign',
      description: 'Generate targeted outreach message for leads',
      icon: Icons.mark_email_unread_outlined,
      prompt: 'Draft a re-engagement email sequence for prospects',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 2.5,
      ),
      itemCount: _actions.length,
      itemBuilder: (context, index) {
        final action = _actions[index];
        return InkWell(
          onTap: () => onActionSelected(action.prompt),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.accentLime.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(action.icon, color: AppColors.accentLime, size: 20),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        action.title,
                        style: AppTypography.bodySmallBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        action.description,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}