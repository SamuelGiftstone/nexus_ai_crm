// lib/app_shell.dart

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_spacing.dart';
import 'core/theme/app_typography.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WindowBorder(
        color: AppColors.borderSubtle,
        width: 1,
        child: Column(
          children: [
            // 1. Desktop Window Frame Controls
            const _DesktopTitleBar(),

            // 2. Centered Top Navigation Bar
            const _TopNavigationBar(),

            // 3. Dynamic Page View
            Expanded(
              child: Container(
                color: const Color(0xFF131316),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopTitleBar extends StatelessWidget {
  const _DesktopTitleBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: const Color(0xFF18181C),
      child: WindowTitleBarBox(
        child: Row(
          children: [
            Expanded(
              child: MoveWindow(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nexus AI CRM',
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.38),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const _WindowButtons(),
          ],
        ),
      ),
    );
  }
}

class _WindowButtons extends StatelessWidget {
  const _WindowButtons();

  @override
  Widget build(BuildContext context) {
    final buttonColors = WindowButtonColors(
      iconNormal: Colors.white.withOpacity(0.54),
      mouseOver: Colors.white.withOpacity(0.10),
      mouseDown: Colors.white.withOpacity(0.24),
      iconMouseOver: Colors.white,
      iconMouseDown: Colors.white,
    );

    final closeButtonColors = WindowButtonColors(
      iconNormal: Colors.white.withOpacity(0.54),
      mouseOver: const Color(0xFFC42B1C),
      mouseDown: const Color(0xFFB82415),
      iconMouseOver: Colors.white,
      iconMouseDown: Colors.white,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class _TopNavigationBar extends StatelessWidget {
  const _TopNavigationBar();

  static const List<_TopNavItem> _navItems = [
    _TopNavItem(label: 'Dashboard', route: '/dashboard'),
    _TopNavItem(label: 'Contacts', route: '/contacts'),
    _TopNavItem(label: 'Companies', route: '/companies'),
    _TopNavItem(label: 'Duplicates', route: '/duplicates'),
    _TopNavItem(label: 'AI Copilot', route: '/copilot'),
    _TopNavItem(label: 'Quotations', route: '/quotations'),
    _TopNavItem(label: 'Analytics', route: '/analytics'),
    _TopNavItem(label: 'Settings', route: '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;

    return Container(
      height: 56,
      color: const Color(0xFF18181C),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: [
          // Left: Brand Logo
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5FF44),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.bolt, color: Colors.black, size: 16),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Nexus AI',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          // Center: Centered Pill Navigation Items
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _navItems.map((item) {
                  final isActive = currentRoute == item.route;
                  return _NavPillButton(
                    item: item,
                    isActive: isActive,
                  );
                }).toList(),
              ),
            ),
          ),

          // Right: Action Buttons & User Profile Dropdown
          const Align(
            alignment: Alignment.centerRight,
            child: _UserProfileWidget(),
          ),
        ],
      ),
    );
  }
}

class _TopNavItem {
  final String label;
  final String route;

  const _TopNavItem({required this.label, required this.route});
}

class _NavPillButton extends StatelessWidget {
  final _TopNavItem item;
  final bool isActive;

  const _NavPillButton({
    required this.item,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          if (!isActive) {
            context.go(item.route);
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            item.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? Colors.black : Colors.white.withOpacity(0.70),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserProfileWidget extends StatelessWidget {
  const _UserProfileWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Notification Icon
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFF26262B),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications_none,
            size: 18,
            color: Colors.white.withOpacity(0.70),
          ),
        ),
        const SizedBox(width: 10),

        // Administrator Profile Chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF26262B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xFFE5FF44),
                child: Text(
                  'A',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Administrator',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Colors.white.withOpacity(0.54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}