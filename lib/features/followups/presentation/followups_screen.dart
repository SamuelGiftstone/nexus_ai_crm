// lib/features/followups/presentation/followups_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/animations/fade_slide_transition.dart';
import '../../../shared/widgets/app_button.dart';
import '../data/followups_repository.dart';
import '../domain/followup_model.dart';
import 'widgets/followup_card.dart';
import 'widgets/followup_schedule_dialog.dart';

class FollowupsScreen extends StatefulWidget {
  const FollowupsScreen({super.key});

  @override
  State<FollowupsScreen> createState() => _FollowupsScreenState();
}

class _FollowupsScreenState extends State<FollowupsScreen> {
  final FollowupsRepository _repository = FollowupsRepository();
  late Future<List<FollowupModel>> _followupsFuture;

  String _searchQuery = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadFollowups();
  }

  void _loadFollowups() {
    setState(() {
      _followupsFuture = _repository.getFollowups();
    });
  }

  void _openScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => FollowupScheduleDialog(
        onSave: (followup) async {
          await _repository.saveFollowup(followup);
          _loadFollowups();
        },
      ),
    );
  }

// Replace _filterFollowups in lib/features/followups/presentation/followups_screen.dart

List<FollowupModel> _filterFollowups(List<FollowupModel> list) {
  return list.where((item) {
    // Search matching title (and any secondary string field if present)
    final matchesSearch = item.title.toLowerCase().contains(_searchQuery.toLowerCase());

    if (!matchesSearch) return false;

    // Check status enum via .name or enum value comparison
    final isCompleted = item.status.name.toLowerCase() == 'completed';

    if (_selectedFilter == 'Pending') {
      return !isCompleted;
    } else if (_selectedFilter == 'Completed') {
      return isCompleted;
    } else if (_selectedFilter == 'High Priority') {
      return item.priority.name.toLowerCase() == 'high';
    }

    return true;
  }).toList();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Follow-ups', style: AppTypography.displayLarge),
                    const SizedBox(height: 2),
                    Text(
                      'Schedule, prioritize, and track customer engagement actions',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                AppButton(
                  label: 'Schedule Follow-up',
                  icon: Icons.add_rounded,
                  variant: AppButtonVariant.primary,
                  onPressed: _openScheduleDialog,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Controls & Filters Bar
            Row(
              children: [
                // Search Input
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: AppTypography.bodySmall.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search follow-ups or notes...',
                        hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                        prefixIcon: const Icon(Icons.search_rounded, size: 16, color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.surfaceCard,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.borderSubtle),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.accentLime),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Filter Pill Group
                Container(
                  height: 38,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Row(
                    children: ['All', 'Pending', 'High Priority', 'Completed'].map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilter = filter),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.accentLime.withOpacity(0.15) : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: isSelected
                                ? Border.all(color: AppColors.accentLime.withOpacity(0.3))
                                : null,
                          ),
                          child: Text(
                            filter,
                            style: AppTypography.bodySmallBold.copyWith(
                              color: isSelected ? AppColors.accentLime : AppColors.textMuted,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Follow-ups Grid List
            Expanded(
              child: FutureBuilder<List<FollowupModel>>(
                future: _followupsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.accentLime),
                    );
                  }

                  final rawList = snapshot.data ?? [];
                  final followups = _filterFollowups(rawList);

                  if (followups.isEmpty) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderSubtle),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.accentLime.withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_circle_outline,
                                size: 36,
                                color: AppColors.accentLime,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text('No Follow-ups Found', style: AppTypography.headingLarge),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              _searchQuery.isNotEmpty || _selectedFilter != 'All'
                                  ? 'No items match your active filters.'
                                  : 'Click "Schedule Follow-up" above to add new customer tasks.',
                              style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: AppSpacing.lg,
                      mainAxisSpacing: AppSpacing.lg,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: followups.length,
                    itemBuilder: (context, index) {
                      final followup = followups[index];
                      return FadeSlideTransition(
                        child: FollowupCard(
                          followup: followup,
                          onTap: () {},
                          onComplete: () async {
                            if (followup.id != null) {
                              await _repository.markCompleted(followup.id!);
                              _loadFollowups();
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}