// lib/features/followups/presentation/widgets/followup_schedule_dialog.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/followup_model.dart';

class FollowupScheduleDialog extends StatefulWidget {
  final Function(FollowupModel) onSave;

  const FollowupScheduleDialog({super.key, required this.onSave});

  @override
  State<FollowupScheduleDialog> createState() => _FollowupScheduleDialogState();
}

class _FollowupScheduleDialogState extends State<FollowupScheduleDialog> {
  final _titleController = TextEditingController();
  final _contactController = TextEditingController();
  final _noteController = TextEditingController();

  FollowupType _selectedType = FollowupType.email;
  FollowupPriority _selectedPriority = FollowupPriority.medium;
  DateTime _scheduledDate = DateTime.now().add(const Duration(days: 1));

  void _submit() {
    if (_titleController.text.isEmpty || _contactController.text.isEmpty) return;

    final followup = FollowupModel(
      contactId: 1,
      contactName: _contactController.text.trim(),
      title: _titleController.text.trim(),
      note: _noteController.text.trim(),
      type: _selectedType,
      priority: _selectedPriority,
      status: FollowupStatus.pending,
      scheduledAt: _scheduledDate,
    );

    widget.onSave(followup);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Schedule Follow-Up', style: AppTypography.headingLarge),
              const SizedBox(height: AppSpacing.lg),

              TextField(
                controller: _titleController,
                style: AppTypography.bodyMedium,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              const SizedBox(height: AppSpacing.md),

              TextField(
                controller: _contactController,
                style: AppTypography.bodyMedium,
                decoration: const InputDecoration(labelText: 'Contact Name'),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Type Selector
              Text('Activity Type', style: AppTypography.bodySmallBold),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.sm,
                children: FollowupType.values.map((type) {
                  final isSelected = _selectedType == type;
                  return ChoiceChip(
                    label: Text(type.name.toUpperCase()),
                    selected: isSelected,
                    selectedColor: AppColors.accentLime,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedType = type);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Priority Selector
              Text('Priority', style: AppTypography.bodySmallBold),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.sm,
                children: FollowupPriority.values.map((p) {
                  final isSelected = _selectedPriority == p;
                  return ChoiceChip(
                    label: Text(p.name.toUpperCase()),
                    selected: isSelected,
                    selectedColor: AppColors.accentLime,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedPriority = p);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),

              TextField(
                controller: _noteController,
                maxLines: 3,
                style: AppTypography.bodyMedium,
                decoration: const InputDecoration(
                  labelText: 'Notes / Context',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  AppButton(
                    label: 'Schedule',
                    variant: AppButtonVariant.primary,
                    onPressed: _submit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}