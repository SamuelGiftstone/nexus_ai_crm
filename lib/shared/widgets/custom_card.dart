// lib/shared/widgets/custom_card.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.backgroundColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final container = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceCard,
        borderRadius: AppRadius.borderLg,
        border: Border.all(color: borderColor ?? AppColors.borderSubtle),
      ),
      child: child,
    );

    if (onTap == null) return container;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderLg,
      child: container,
    );
  }
}