// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

import 'app.dart';
import 'core/services/window_service.dart';

void main() async {
  // 1. Ensure Flutter binding is initialized first
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize native window effects (Mica/Acrylic) safely
  try {
    await Window.initialize();
    await Window.setEffect(
      effect: WindowEffect.mica,
      dark: true,
    );
  } catch (e) {
    debugPrint('Failed to initialize native window effect: $e');
  }

  // 3. Launch the Root Application Widget
  runApp(const NexusApp());

  // 4. Configure bitsdojo_window frame boundaries
  WindowService.initialize();
}