// lib/features/duplicates/presentation/duplicates_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/animations/fade_slide_transition.dart';
import '../data/duplicates_repository.dart';
import '../domain/duplicate_cluster.dart';

class DuplicatesScreen extends StatefulWidget {
  const DuplicatesScreen({super.key});

  @override
  State<DuplicatesScreen> createState() => _DuplicatesScreenState();
}

class _DuplicatesScreenState extends State<DuplicatesScreen> {
  final DuplicatesRepository _repository = DuplicatesRepository();
  late Future<List<DuplicateCluster>> _clustersFuture;

  @override
  void initState() {
    super.initState();
    _scanDuplicates();
  }

  void _scanDuplicates() {
    setState(() {
      _clustersFuture = _repository.findDuplicates();
    });
  }

  Future<void> _mergeCluster(DuplicateCluster cluster) async {
    final primary = cluster.primaryContact;
    final candidate = cluster.duplicateCandidates.first;

    final merged = primary.copyWith(
      dealValue: primary.dealValue >= candidate.dealValue
          ? primary.dealValue
          : candidate.dealValue,
      phone: (primary.phone?.isNotEmpty ?? false)
          ? primary.phone
          : candidate.phone,
      company: (primary.company?.isNotEmpty ?? false)
          ? primary.company
          : candidate.company,
    );

    await _repository.mergeContacts(
      mergedContact: merged,
      idsToDelete: cluster.duplicateCandidates
          .where((c) => c.id != null)
          .map((c) => c.id is int ? c.id as int : int.parse(c.id.toString()))
          .toList(),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contacts successfully merged'),
          backgroundColor: AppColors.success,
        ),
      );
      _scanDuplicates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // 1. Compact Header Bar
            _CompactHeader(
              onRescan: _scanDuplicates,
            ),
            const SizedBox(height: AppSpacing.sm),

            // 2. Main Content Area
            Expanded(
              child: FutureBuilder<List<DuplicateCluster>>(
                future: _clustersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accentLime,
                      ),
                    );
                  }

                  final clusters = snapshot.data ?? [];

                  if (clusters.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 40,
                            color: AppColors.success,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'No Duplicate Records Found',
                            style: AppTypography.headingMedium,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Your database contact store is clean and unique.',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: clusters.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      final cluster = clusters[index];
                      return FadeSlideTransition(
                        child: _CompactClusterCard(
                          cluster: cluster,
                          onMerge: () => _mergeCluster(cluster),
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

// Compact Header Bar with Actions & Quick Search
class _CompactHeader extends StatelessWidget {
  final VoidCallback onRescan;

  const _CompactHeader({required this.onRescan});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Duplicate Management',
          style: AppTypography.headingMedium.copyWith(fontSize: 16),
        ),
        const SizedBox(width: AppSpacing.md),

        // Compact Filter / Search Bar
        Expanded(
          child: Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  size: 14,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 8),
                Text(
                  'Search duplicated leads...',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),

        // Compact Re-Scan Pill Button
        InkWell(
          onTap: onRescan,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.refresh_rounded,
                  size: 14,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  'Re-scan',
                  style: AppTypography.labelBold.copyWith(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Compact Duplicate Cluster Card Component
class _CompactClusterCard extends StatelessWidget {
  final DuplicateCluster cluster;
  final VoidCallback onMerge;

  const _CompactClusterCard({
    required this.cluster,
    required this.onMerge,
  });

  @override
  Widget build(BuildContext context) {
    final primary = cluster.primaryContact;
    final candidates = cluster.duplicateCandidates;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Primary Contact Avatar & Info
          Container(
            width: 240,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.accentLime,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.person, size: 16, color: Colors.black),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        primary.fullName ?? 'Unknown',
                        style: AppTypography.labelBold.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        primary.email ?? 'No Email',
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.black87,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Duplicate Candidates Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Candidates (${candidates.length})',
                  style: AppTypography.labelBold.copyWith(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  candidates.map((c) => c.fullName).join(', '),
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Compact Merge Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentLime,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 8,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: onMerge,
            icon: const Icon(Icons.merge_type, size: 14),
            label: Text(
              'Merge Cluster',
              style: AppTypography.labelBold.copyWith(
                fontSize: 11,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}