// lib/features/dashboard/presentation/widgets/ai_summary_widget.dart

import 'package:flutter/material.dart';
import '../../../../core/services/ollama_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_button.dart';

class AiSummaryWidget extends StatefulWidget {
  final String promptContext;

  const AiSummaryWidget({
    super.key,
    required this.promptContext,
  });

  @override
  State<AiSummaryWidget> createState() => _AiSummaryWidgetState();
}

class _AiSummaryWidgetState extends State<AiSummaryWidget> {
  final OllamaService _ollamaService = OllamaService();
  String _summaryText = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateBrief();
  }

  Future<void> _generateBrief() async {
    setState(() => _isLoading = true);

    try {
      final response = await _ollamaService.generateResponse(
        prompt: 'Provide a brief 2-sentence tactical summary for this business state.',
        crmContextJson: widget.promptContext,
      );

      if (mounted) {
        setState(() {
          _summaryText = response.trim();
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _summaryText =
              'Focus pipeline efforts on qualified leads this week to maximize velocity and seal high-value enterprise accounts.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.surfaceCard,
            AppColors.accentLime.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.borderLg,
        border: Border.all(color: AppColors.accentLime.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.accentLime, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text('Gemma Executive Brief', style: AppTypography.headingMedium),
              const Spacer(),
              AppButton(
                label: 'Refresh',
                variant: AppButtonVariant.text,
                icon: Icons.refresh_rounded,
                isLoading: _isLoading,
                onPressed: _generateBrief,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.accentLime,
                    ),
                  ),
                )
              : Text(
                  _summaryText,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
        ],
      ),
    );
  }
}