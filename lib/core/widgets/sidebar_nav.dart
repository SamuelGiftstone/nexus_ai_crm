// lib/core/widgets/sidebar_nav.dart

import 'package:flutter/material.dart';

class SidebarNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const SidebarNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  static const List<Map<String, dynamic>> navItems = [
    {'title': 'Dashboard', 'icon': Icons.grid_view_rounded},
    {'title': 'Contacts', 'icon': Icons.people_outline_rounded},
    {'title': 'Companies', 'icon': Icons.business_outlined},
    {'title': 'Deals', 'icon': Icons.view_kanban_outlined},
    {'title': 'Quotations', 'icon': Icons.description_outlined},
    {'title': 'Follow-ups', 'icon': Icons.event_note_outlined},
    {'title': 'Duplicates', 'icon': Icons.filter_center_focus_rounded},
    {'title': 'AI Copilot', 'icon': Icons.auto_awesome_rounded, 'isAi': true},
    {'title': 'Analytics', 'icon': Icons.bar_chart_rounded},
    {'title': 'Settings', 'icon': Icons.settings_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: const Color(0xFF141419),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo & Branding Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2F66FF),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2F66FF).withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.bolt, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nexus AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    Text(
                      'Offline OS v1.0',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(color: Color(0xFF24242D), height: 1),
          const SizedBox(height: 12),

          // Menu List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: navItems.length,
              separatorBuilder: (_, index) {
                // Add visual spacing before AI Copilot and Settings
                if (index == 6 || index == 8) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Color(0xFF24242D), height: 1),
                  );
                }
                return const SizedBox(height: 4);
              },
              itemBuilder: (context, index) {
                final item = navItems[index];
                final isSelected = selectedIndex == index;
                final isAi = item['isAi'] == true;

                return InkWell(
                  onTap: () => onDestinationSelected(index),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected
                          ? (isAi
                              ? const Color(0xFFA8FF53).withOpacity(0.15)
                              : const Color(0xFF2F66FF).withOpacity(0.15))
                          : Colors.transparent,
                      border: isSelected
                          ? Border.all(
                              color: isAi
                                  ? const Color(0xFFA8FF53).withOpacity(0.5)
                                  : const Color(0xFF2F66FF).withOpacity(0.4),
                              width: 1,
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: 18,
                          color: isSelected
                              ? (isAi ? const Color(0xFFA8FF53) : Colors.white)
                              : (isAi
                                  ? const Color(0xFFA8FF53).withOpacity(0.8)
                                  : Colors.white54),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item['title'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected
                                ? (isAi ? const Color(0xFFA8FF53) : Colors.white)
                                : Colors.white54,
                          ),
                        ),
                        if (isAi && !isSelected) ...[
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFA8FF53).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Gemma',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA8FF53),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Offline Daemon Status Indicator
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C24),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2B2B36)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA8FF53), // Active Offline Status
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Local AI Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Gemma 3B • Ollama',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 10,
                        ),
                      ),
                    ],
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