import 'package:flutter/material.dart';

import '../../theme/spacing.dart';
import '../buttons/app_button.dart';

/// A widget that displays an empty state with icon, title, and optional action
///
/// Example usage:
/// ```dart
/// AppEmptyState(
///   icon: Icons.inbox_outlined,
///   title: 'No messages',
///   message: 'You don\'t have any messages yet.',
/// )
///
/// AppEmptyState(
///   icon: Icons.search_off_outlined,
///   title: 'No results found',
///   message: 'Try adjusting your search.',
///   actionText: 'Clear filters',
///   onAction: () => clearFilters(),
/// )
/// ```
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionText,
    this.onAction,
    this.iconSize = 80,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionText;
  final VoidCallback? onAction;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton(text: actionText!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}

/// A widget that displays an error state with icon, title, and retry action
///
/// Example usage:
/// ```dart
/// AppErrorState(
///   title: 'Failed to load data',
///   message: 'Please check your connection and try again.',
///   onRetry: () => loadData(),
/// )
/// ```
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.title,
    this.message,
    this.onRetry,
    this.retryText = 'Try again',
    this.icon = Icons.error_outline,
    this.iconSize = 80,
  });

  final String title;
  final String? message;
  final VoidCallback? onRetry;
  final String retryText;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: iconSize, color: colorScheme.error),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                text: retryText,
                onPressed: onRetry,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A widget that displays network error state
///
/// Example usage:
/// ```dart
/// AppNetworkErrorState(
///   onRetry: () => fetchData(),
/// )
/// ```
class AppNetworkErrorState extends StatelessWidget {
  const AppNetworkErrorState({
    super.key,
    this.onRetry,
    this.title = 'No internet connection',
    this.message = 'Please check your connection and try again.',
  });

  final VoidCallback? onRetry;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AppErrorState(
      icon: Icons.wifi_off_outlined,
      title: title,
      message: message,
      onRetry: onRetry,
    );
  }
}

/// A widget that displays a coming soon state
///
/// Example usage:
/// ```dart
/// AppComingSoonState(
///   title: 'Coming Soon',
///   message: 'This feature will be available in the next update.',
/// )
/// ```
class AppComingSoonState extends StatelessWidget {
  const AppComingSoonState({
    super.key,
    this.title = 'Coming Soon',
    this.message =
        'This feature is under development and will be available soon.',
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.upcoming_outlined,
                size: 80,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that displays a maintenance state
///
/// Example usage:
/// ```dart
/// AppMaintenanceState(
///   title: 'Under Maintenance',
///   message: 'We\'re making improvements. Please check back soon.',
/// )
/// ```
class AppMaintenanceState extends StatelessWidget {
  const AppMaintenanceState({
    super.key,
    this.title = 'Under Maintenance',
    this.message =
        'We\'re currently performing maintenance. Please check back soon.',
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.construction_outlined,
                size: 80,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that displays a no permission state
///
/// Example usage:
/// ```dart
/// AppNoPermissionState(
///   title: 'Permission Required',
///   message: 'You need permission to access this feature.',
///   onRequestPermission: () => requestPermission(),
/// )
/// ```
class AppNoPermissionState extends StatelessWidget {
  const AppNoPermissionState({
    super.key,
    this.title = 'Permission Required',
    this.message = 'You don\'t have permission to access this feature.',
    this.onRequestPermission,
    this.actionText = 'Request Permission',
  });

  final String title;
  final String message;
  final VoidCallback? onRequestPermission;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_outline,
                size: 80,
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRequestPermission != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                text: actionText,
                onPressed: onRequestPermission,
                icon: Icons.vpn_key_outlined,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
