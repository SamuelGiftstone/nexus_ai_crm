// lib/shared/dialogs/ai_prompt_modal.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../widgets/app_button.dart';

class AiPromptModal extends StatefulWidget {
  final String initialPrompt;
  final ValueChanged<String> onSubmit;

  const AiPromptModal({
    super.key,
    this.initialPrompt = '',
    required this.onSubmit,
  });

  static void show(
    BuildContext context, {
    String initialPrompt = '',
    required ValueChanged<String> onSubmit,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AiPromptModal(
        initialPrompt: initialPrompt,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<AiPromptModal> createState() => _AiPromptModalState();
}

class _AiPromptModalState extends State<AiPromptModal> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialPrompt);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppColors.borderHighlight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.accentLime, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text('Query Gemma AI Offline', style: AppTypography.headingLarge),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _controller,
            maxLines: 4,
            autofocus: true,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Describe what context or summary you need...',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                label: 'Cancel',
                variant: AppButtonVariant.text,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppButton(
                label: 'Run Analysis',
                variant: AppButtonVariant.lime,
                icon: Icons.bolt,
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    widget.onSubmit(text);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}