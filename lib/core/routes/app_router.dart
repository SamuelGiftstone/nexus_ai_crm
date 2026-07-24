// lib/core/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexus_ai_crm/features/analytics/presentation/analytics_screen.dart';
import 'package:nexus_ai_crm/features/companies/presentation/companies_screen.dart';
import 'package:nexus_ai_crm/features/quotations/presentation/quotations_screen.dart';
import 'package:nexus_ai_crm/features/settings/presentation/settings_screen.dart';
import '../../app_shell.dart';
import '../../features/contacts/presentation/contacts_screen.dart';
import '../../features/copilot/presentation/copilot_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/duplicates/presentation/duplicates_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

// Import remaining feature screens as you build them out:
// import '../../features/companies/presentation/companies_screen.dart';
// import '../../features/deals/presentation/deals_screen.dart';
// import '../../features/quotations/presentation/quotations_screen.dart';
// import '../../features/analytics/presentation/analytics_screen.dart';
// import '../../features/settings/presentation/settings_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    // 1. Splash Screen Outside Shell
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(
        onInitializationComplete: () {
          context.go('/dashboard');
        },
      ),
    ),

    // 2. Main App Shell (Persistent Navigation & Frame Header)
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/contacts',
          builder: (context, state) => const ContactsScreen(),
        ),
        GoRoute(
          path: '/companies',
          builder: (context, state) => const CompaniesScreen()
          // Replace with: const CompaniesScreen(),
        ),
        GoRoute(
          path: '/deals',
          builder: (context, state) => const PlaceholderScreen(title: 'Deals'),
          // Replace with: const DealsScreen(),
        ),
        GoRoute(
          path: '/duplicates',
          builder: (context, state) => const DuplicatesScreen(),
        ),
        GoRoute(
          path: '/copilot',
          builder: (context, state) => const CopilotScreen(),
        ),
        GoRoute(
          path: '/quotations',
          builder: (context, state) => const QuotationsScreen(),
          //Replace with: const QuotationsScreen(),
        ),
        GoRoute(
          path: '/analytics',
          builder: (context, state) => const AnalyticsScreen(),
          // Replace with: const AnalyticsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
          // Replace with: const SettingsScreen(),
        ),
      ],
    ),
  ],
);

/// Temporary placeholder widget until remaining screens are created
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          '$title Module (Under Construction)',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white.withOpacity(0.70),
              ),
        ),
      ),
    );
  }
}