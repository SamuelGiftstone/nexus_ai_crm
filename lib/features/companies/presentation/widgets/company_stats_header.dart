import 'package:flutter/material.dart';

class CompanyStatsHeader extends StatelessWidget {
  final int totalCompanies;
  final int activeDeals;
  final String totalPipelineValue;
  final int aiContextIndexedCount;

  const CompanyStatsHeader({
    super.key,
    this.totalCompanies = 1284,
    this.activeDeals = 142,
    this.totalPipelineValue = '\$10.2M',
    this.aiContextIndexedCount = 982,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Total Companies',
            value: totalCompanies.toString(),
            subtitle: '+12 added this month',
            icon: Icons.business_rounded,
            accentColor: const Color(0xFF2F66FF),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Active Deals',
            value: activeDeals.toString(),
            subtitle: 'Across 34 accounts',
            icon: Icons.view_kanban_outlined,
            accentColor: const Color(0xFFFFB020),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Pipeline Value',
            value: totalPipelineValue,
            subtitle: 'Weighted forecast',
            icon: Icons.payments_outlined,
            accentColor: const Color(0xFF00C853),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Local RAG Indexed',
            value: '$aiContextIndexedCount / $totalCompanies',
            subtitle: 'Gemma 3B Context Ready',
            icon: Icons.auto_awesome_rounded,
            accentColor: const Color(0xFFA8FF53),
            isAiTile: true,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final bool isAiTile;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    this.isAiTile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141419),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isAiTile 
              ? accentColor.withOpacity(0.3) 
              : const Color(0xFF24242D),
          width: 1,
        ),
        boxShadow: isAiTile
            ? [
                BoxShadow(
                  color: accentColor.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: accentColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isAiTile ? accentColor : Colors.white.withOpacity(0.35),
                    fontSize: 10,
                    fontWeight: isAiTile ? FontWeight.w600 : FontWeight.w400,
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