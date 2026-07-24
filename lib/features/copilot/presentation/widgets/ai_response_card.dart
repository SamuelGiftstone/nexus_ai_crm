// lib/features/copilot/presentation/widgets/ai_response_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/copilot_message.dart';
import 'suggestion_chip.dart';

class AiResponseCard extends StatelessWidget {
  final CopilotMessage message;
  final Function(String)? onSuggestionTap;

  const AiResponseCard({
    super.key,
    required this.message,
    this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == CopilotSender.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.accentLime.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const ExcludeSemantics(
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 18,
                  color: AppColors.accentLime,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: isUser ? AppColors.accentLime : AppColors.surfaceCard,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                border: isUser ? null : Border.all(color: AppColors.borderSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.isThinking)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.accentLime,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Flexible(
                          child: Text(
                            'Analyzing database & generating insights...',
                            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                          ),
                        ),
                      ],
                    )
                  else
                    SelectableText(
                      message.content,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isUser ? AppColors.surfaceDark : AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),

                  // Preset Action Suggestions
                  if (!isUser &&
                      message.suggestedActions != null &&
                      message.suggestedActions!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    const Divider(color: AppColors.borderSubtle, height: 1),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: message.suggestedActions!.map((action) {
                        return SuggestionChip(
                          label: action,
                          onTap: () => onSuggestionTap?.call(action),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: AppSpacing.md),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surfaceDark,
              child: Text(
                'ME',
                style: AppTypography.bodySmallBold.copyWith(
                  color: AppColors.accentLime,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}