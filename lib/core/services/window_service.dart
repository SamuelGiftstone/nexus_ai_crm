// lib/core/services/window_service.dart

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class WindowService {
  static void initialize() {
    doWhenWindowReady(() {
      // 1080x650 fits comfortably on 1366x768 screens without touching the taskbar
      const initialSize = Size(1080, 650);
      
      final minSize = Size(
        AppConstants.minWindowWidth, 
        AppConstants.minWindowHeight,
      );

      appWindow.minSize = minSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = 'Nexus AI CRM';
      appWindow.show();
    });
  }
}