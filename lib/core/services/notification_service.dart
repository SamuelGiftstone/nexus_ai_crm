// lib/core/services/notification_service.dart

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

enum NotificationType { info, success, warning, error, ai }

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Displays an enterprise-styled desktop banner/toast at the bottom right of the screen
  void showNotification(
    BuildContext context, {
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
  }) {
    final scaffold = ScaffoldMessenger.of(context);

    Color accentColor;
    IconData icon;

    switch (type) {
      case NotificationType.success:
        accentColor = AppColors.success;
        icon = Icons.check_circle_outline;
        break;
      case NotificationType.warning:
        accentColor = AppColors.warning;
        icon = Icons.warning_amber_rounded;
        break;
      case NotificationType.error:
        accentColor = AppColors.error;
        icon = Icons.error_outline;
        break;
      case NotificationType.ai:
        accentColor = AppColors.accentPurple;
        icon = Icons.auto_awesome;
        break;
      case NotificationType.info:
      default:
        accentColor = AppColors.accentBlue;
        icon = Icons.info_outline;
        break;
    }

    scaffold.showSnackBar(
      SnackBar(
        duration: duration,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        width: 380,
        margin: const EdgeInsets.only(bottom: AppSpacing.lg, right: AppSpacing.lg),
        content: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: AppRadius.borderLg,
            border: Border.all(color: AppColors.borderHighlight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs + 2),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 18),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTypography.headingSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textMuted),
                  onPressed: onTap,
                ),
            ],
          ),
        ),
      ),
    );
  }
}