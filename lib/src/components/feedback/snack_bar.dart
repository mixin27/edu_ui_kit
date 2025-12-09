import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import '../../theme/color_tokens.dart';
import '../../theme/spacing.dart';

/// Shows a snackbar with customizable styling and actions
///
/// Example usage:
/// ```dart
/// AppSnackbar.show(
///   context,
///   message: 'Task completed successfully',
/// )
///
/// AppSnackbar.success(
///   context,
///   message: 'Grade updated',
/// )
///
/// AppSnackbar.error(
///   context,
///   message: 'Failed to save',
///   action: SnackBarAction(label: 'Retry', onPressed: () {}),
/// )
/// ```
class AppSnackbar {
  /// Shows a standard snackbar
  static void show(
    BuildContext context, {
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 20,
                color: foregroundColor ?? colorScheme.onInverseSurface,
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor ?? colorScheme.onInverseSurface,
                ),
              ),
            ),
          ],
        ),
        action: action,
        duration: duration,
        backgroundColor: backgroundColor ?? colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
      ),
    );
  }

  /// Shows a success snackbar (green)
  static void success(
    BuildContext context, {
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      action: action,
      duration: duration,
      icon: Icons.check_circle_outline,
      backgroundColor: ColorTokens().success,
      foregroundColor: Colors.white,
    );
  }

  /// Shows an error snackbar (red)
  static void error(
    BuildContext context, {
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      action: action,
      duration: duration,
      icon: Icons.error_outline,
      backgroundColor: ColorTokens().error,
      foregroundColor: Colors.white,
    );
  }

  /// Shows a warning snackbar (amber)
  static void warning(
    BuildContext context, {
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      action: action,
      duration: duration,
      icon: Icons.warning_amber_outlined,
      backgroundColor: ColorTokens().warning,
      foregroundColor: Colors.white,
    );
  }

  /// Shows an info snackbar (blue)
  static void info(
    BuildContext context, {
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      action: action,
      duration: duration,
      icon: Icons.info_outline,
      backgroundColor: ColorTokens().info,
      foregroundColor: Colors.white,
    );
  }

  /// Hides the current snackbar
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

/// A custom toast widget that appears at the top or bottom
///
/// Example usage:
/// ```dart
/// AppToast.show(
///   context,
///   message: 'Message sent',
///   position: ToastPosition.top,
/// )
/// ```
class AppToast {
  static OverlayEntry? _currentToast;

  static void show(
    BuildContext context, {
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    ToastType type = ToastType.info,
  }) {
    // Remove existing toast
    _currentToast?.remove();

    final overlay = Overlay.of(context);
    final theme = Theme.of(context);

    _currentToast = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        position: position,
        type: type,
        theme: theme,
      ),
    );

    overlay.insert(_currentToast!);

    // Auto-dismiss after duration
    Future.delayed(duration, () {
      _currentToast?.remove();
      _currentToast = null;
    });
  }

  static void success(
    BuildContext context, {
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      position: position,
      duration: duration,
      type: ToastType.success,
    );
  }

  static void error(
    BuildContext context, {
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      position: position,
      duration: duration,
      type: ToastType.error,
    );
  }

  static void warning(
    BuildContext context, {
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      position: position,
      duration: duration,
      type: ToastType.warning,
    );
  }

  static void info(
    BuildContext context, {
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      position: position,
      duration: duration,
      type: ToastType.info,
    );
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.position,
    required this.type,
    required this.theme,
  });

  final String message;
  final ToastPosition position;
  final ToastType type;
  final ThemeData theme;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.durationMedium,
      vsync: this,
    );

    final begin = widget.position == ToastPosition.top
        ? const Offset(0, -1)
        : const Offset(0, 1);

    _slideAnimation = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.curveEaseOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    final colors = ColorTokens();
    switch (widget.type) {
      case ToastType.success:
        return colors.success;
      case ToastType.error:
        return colors.error;
      case ToastType.warning:
        return colors.warning;
      case ToastType.info:
        return colors.info;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle_outline;
      case ToastType.error:
        return Icons.error_outline;
      case ToastType.warning:
        return Icons.warning_amber_outlined;
      case ToastType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position == ToastPosition.top ? AppSpacing.xl : null,
      bottom: widget.position == ToastPosition.bottom ? AppSpacing.xl : null,
      left: AppSpacing.md,
      right: AppSpacing.md,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: AppSpacing.paddingMD,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius: BorderRadius.circular(AppRadius.md),
                boxShadow: AppElevation.elevatedShadow,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_getIcon(), color: Colors.white, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(
                    child: Text(
                      widget.message,
                      style: widget.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum ToastPosition { top, bottom }

enum ToastType { success, error, warning, info }
