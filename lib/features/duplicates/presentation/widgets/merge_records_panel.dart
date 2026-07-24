// lib/features/duplicates/presentation/widgets/merge_records_panel.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class MergeRecordsPanel extends StatefulWidget {
  const MergeRecordsPanel({super.key});

  @override
  State<MergeRecordsPanel> createState() => _MergeRecordsPanelState();
}

class _MergeRecordsPanelState extends State<MergeRecordsPanel> {
  // Field selection tracker (maps field name to selected candidate index)
  final Map<String, int> _selectedFields = {
    'Name': 0,
    'Position': 0,
    'Email': 1,
    'Office Phone': 0,
    'Website': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Merge 3 duplicated records', style: AppTypography.headingLarge),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.merge_type, size: 16),
                label: const Text('Merge Duplicates'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Horizontal Candidate Cards
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _CandidateColumn(
                    candidateIndex: 0,
                    name: 'Mishel Cohen',
                    company: 'Tonal Inc',
                    avatarUrl: 'https://i.pravatar.cc/300?img=5',
                    color: AppColors.accentPurple,
                    isSelected: true,
                    fields: const {
                      'Name': 'Mishel',
                      'Position': 'COO, CFO',
                      'Email': 'mishel@tonal.com',
                      'Office Phone': '053-45-00-803',
                      'Website': 'tonal.com',
                    },
                    selectedFields: _selectedFields,
                    onSelectField: (field) {
                      setState(() => _selectedFields[field] = 0);
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _CandidateColumn(
                    candidateIndex: 1,
                    name: 'Mishel Cohen',
                    company: 'Tonal Ink',
                    avatarUrl: 'https://i.pravatar.cc/300?img=9',
                    color: AppColors.accentLime,
                    isSelected: false,
                    fields: const {
                      'Name': 'Micshel',
                      'Position': 'COO',
                      'Email': 'titan.ink@gmail.com',
                      'Office Phone': '054-20-19-888',
                      'Website': 'tonal.ink',
                    },
                    selectedFields: _selectedFields,
                    onSelectField: (field) {
                      setState(() => _selectedFields[field] = 1);
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _CandidateColumn(
                    candidateIndex: 2,
                    name: 'Mishel Cohen',
                    company: 'Tonal Inc',
                    avatarUrl: 'https://i.pravatar.cc/300?img=8',
                    color: AppColors.surfaceDark,
                    isSelected: false,
                    fields: const {
                      'Name': 'Mishel',
                      'Position': 'CFO',
                      'Email': 'mishel.tonelink@gmail.com',
                      'Office Phone': '054-29-00-037',
                      'Website': 'mtmbank.com',
                    },
                    selectedFields: _selectedFields,
                    onSelectField: (field) {
                      setState(() => _selectedFields[field] = 2);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CandidateColumn extends StatelessWidget {
  final int candidateIndex;
  final String name;
  final String company;
  final String avatarUrl;
  final Color color;
  final bool isSelected;
  final Map<String, String> fields;
  final Map<String, int> selectedFields;
  final Function(String) onSelectField;

  const _CandidateColumn({
    required this.candidateIndex,
    required this.name,
    required this.company,
    required this.avatarUrl,
    required this.color,
    required this.isSelected,
    required this.fields,
    required this.selectedFields,
    required this.onSelectField,
  });

  @override
  Widget build(BuildContext context) {
    final isPurpleHeader = color == AppColors.accentPurple;
    final isLimeHeader = color == AppColors.accentLime;

    Color textColor = Colors.white;
    if (isLimeHeader) textColor = Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          // Header Tag
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.radiusLg),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.labelBold.copyWith(color: textColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        company,
                        style: AppTypography.bodySmall.copyWith(
                          color: textColor.withOpacity(0.8),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Fields List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              children: fields.entries.map((entry) {
                final fieldKey = entry.key;
                final fieldValue = entry.value;
                final isChosen = selectedFields[fieldKey] == candidateIndex;

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: InkWell(
                    onTap: () => onSelectField(fieldKey),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm + 2,
                      ),
                      decoration: BoxDecoration(
                        color: isChosen ? color : AppColors.surfaceCard,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(
                          color: isChosen ? Colors.transparent : AppColors.borderSubtle,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              fieldValue,
                              style: AppTypography.bodySmall.copyWith(
                                color: isChosen
                                    ? (isLimeHeader ? Colors.black : Colors.white)
                                    : AppColors.textSecondary,
                                fontWeight: isChosen ? FontWeight.bold : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isChosen
                                  ? (isLimeHeader ? Colors.black : Colors.white)
                                  : AppColors.borderHighlight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}