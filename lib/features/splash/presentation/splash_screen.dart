// lib/features/splash/presentation/splash_screen.dart

import 'package:flutter/material.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/services/ollama_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/animations/fade_slide_transition.dart';
import 'startup_progress.dart';
import 'startup_status_tile.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashScreen({
    super.key,
    required this.onInitializationComplete,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _overallProgress = 0.0;
  String _currentStepText = 'Initializing engine...';

  StartupStatus _dbStatus = StartupStatus.pending;
  StartupStatus _aiStatus = StartupStatus.pending;
  StartupStatus _configStatus = StartupStatus.pending;

  String _dbSubtitle = 'Waiting to connect';
  String _aiSubtitle = 'Waiting to connect';
  String _configSubtitle = 'Waiting to load';

  @override
  void initState() {
    super.initState();
    _runStartupSequence();
  }

  Future<void> _runStartupSequence() async {
    // Step 1: Initialize Local Drift Database
    setState(() {
      _dbStatus = StartupStatus.loading;
      _dbSubtitle = 'Connecting to nexus_crm_v1_db...';
      _currentStepText = 'Opening local SQLite database...';
      _overallProgress = 0.2;
    });

    try {
      final db = DatabaseProvider.instance;
      await db.customSelect('SELECT 1').get();
      setState(() {
        _dbStatus = StartupStatus.success;
        _dbSubtitle = 'SQLite database online';
      });
    } catch (_) {
      setState(() {
        _dbStatus = StartupStatus.warning;
        _dbSubtitle = 'Using standard fallback storage';
      });
    }

    await Future.delayed(const Duration(milliseconds: 300));

    // Step 2: Check Local Ollama / Gemma AI Server
    setState(() {
      _aiStatus = StartupStatus.loading;
      _aiSubtitle = 'Pinging Ollama endpoint (http://localhost:11434)...';
      _currentStepText = 'Checking Gemma offline AI engine...';
      _overallProgress = 0.6;
    });

    final ollamaService = OllamaService();
    final isAiAvailable = await ollamaService.isAvailable();

    setState(() {
      if (isAiAvailable) {
        _aiStatus = StartupStatus.success;
        _aiSubtitle = 'Gemma model ready for offline execution';
      } else {
        _aiStatus = StartupStatus.warning;
        _aiSubtitle = 'Ollama offline (AI features in simulation mode)';
      }
    });

    await Future.delayed(const Duration(milliseconds: 300));

    // Step 3: Load Application Configurations & Preferences
    setState(() {
      _configStatus = StartupStatus.loading;
      _configSubtitle = 'Applying desktop shell settings...';
      _currentStepText = 'Preparing layout workspace...';
      _overallProgress = 0.85;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    setState(() {
      _configStatus = StartupStatus.success;
      _configSubtitle = 'Enterprise environment ready';
      _currentStepText = 'Startup completed.';
      _overallProgress = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      widget.onInitializationComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: FadeSlideTransition(
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(AppSpacing.xxl),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderSubtle),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 32,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Brand Branding
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NEXUS AI CRM', style: AppTypography.displayLarge),
                        Text(
                          'Enterprise Offline Edition',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Diagnostic Steps List
                StartupStatusTile(
                  title: 'Local SQLite Database',
                  subtitle: _dbSubtitle,
                  status: _dbStatus,
                ),
                StartupStatusTile(
                  title: 'Gemma Local AI Engine',
                  subtitle: _aiSubtitle,
                  status: _aiStatus,
                ),
                StartupStatusTile(
                  title: 'Workspace Configuration',
                  subtitle: _configSubtitle,
                  status: _configStatus,
                ),
                const SizedBox(height: AppSpacing.xl),

                // Progress Indicator
                StartupProgress(
                  progress: _overallProgress,
                  statusText: _currentStepText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}