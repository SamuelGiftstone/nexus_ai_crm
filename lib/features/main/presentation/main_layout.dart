// lib/features/main/presentation/main_layout.dart

import 'package:flutter/material.dart';
import 'package:nexus_ai_crm/core/widgets/sidebar_nav.dart';
import 'package:nexus_ai_crm/features/duplicates/presentation/duplicates_screen.dart';

// Import your page views here
import '../../dashboard/presentation/dashboard_screen.dart';
import '../../contacts/presentation/contacts_screen.dart';
import '../../companies/presentation/companies_screen.dart';
import '../../quotations/presentation/quotations_screen.dart';
import '../../followups/presentation/followups_screen.dart';
import '../../copilot/presentation/copilot_screen.dart';
import '../../analytics/presentation/analytics_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  // Ensure these match the 10 navItems in SidebarNav in order!
  final List<Widget> _pages = const [
    DashboardScreen(),
    ContactsScreen(),
    CompaniesScreen(),
    //DealsScreen(),
    QuotationsScreen(),
    FollowupsScreen(),
    DuplicatesScreen(),
    CopilotScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarNav(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}