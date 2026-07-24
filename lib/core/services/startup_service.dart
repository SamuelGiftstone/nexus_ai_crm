// lib/core/services/startup_service.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'ollama_service.dart';
import 'window_service.dart';

enum StartupStage {
  initializeWindow,
  openDatabase,
  loadSettings,
  checkOllama,
  cachePrompts,
  complete,
}

class StartupStatus {
  final StartupStage stage;
  final String message;
  final double progress;

  const StartupStatus({
    required this.stage,
    required this.message,
    required this.progress,
  });
}

class StartupService {
  final OllamaService _ollamaService;

  StartupService({required OllamaService ollamaService})
      : _ollamaService = ollamaService;

  Stream<StartupStatus> initialize() async* {
    yield const StartupStatus(
      stage: StartupStage.initializeWindow,
      message: 'Configuring Windows desktop environment...',
      progress: 0.15,
    );
    // Remove 'await' since WindowService.initialize() is a void synchronous call
    WindowService.initialize();
    await Future.delayed(const Duration(milliseconds: 300));

    yield const StartupStatus(
      stage: StartupStage.openDatabase,
      message: 'Initializing SQLite local engine...',
      progress: 0.35,
    );
    // SQLite initialized here via database provider
    await Future.delayed(const Duration(milliseconds: 300));

    yield const StartupStatus(
      stage: StartupStage.loadSettings,
      message: 'Loading workspace preferences...',
      progress: 0.55,
    );
    await Future.delayed(const Duration(milliseconds: 200));

    yield const StartupStatus(
      stage: StartupStage.checkOllama,
      message: 'Connecting to local Gemma AI engine...',
      progress: 0.80,
    );
    final isOllamaReady = await _ollamaService.isAvailable();

    yield StartupStatus(
      stage: StartupStage.cachePrompts,
      message: isOllamaReady
          ? 'Gemma AI online. Pre-caching prompt templates...'
          : 'Ollama offline. Running in standard mode...',
      progress: 0.95,
    );
    await Future.delayed(const Duration(milliseconds: 300));

    yield const StartupStatus(
      stage: StartupStage.complete,
      message: 'Startup sequence completed.',
      progress: 1.0,
    );
  }
}