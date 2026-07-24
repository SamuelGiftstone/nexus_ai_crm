// lib/app.dart

import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_colors.dart';

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nexus AI CRM',
      debugShowCheckedModeBanner: false,
      
      // GoRouter Configuration
      routerConfig: appRouter,

      // Dark Theme Setup matching AppColors
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent, // Lets native Mica show through
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentBlue,
          surface: AppColors.surfaceDark,
        ),
      ),
    );
  }
}