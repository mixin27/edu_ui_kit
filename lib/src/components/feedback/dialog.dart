import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import '../../theme/spacing.dart';
import '../buttons/app_button.dart';

/// Shows a customizable dialog
///
/// Example usage:
/// ```dart
/// AppDialog.show(
///   context,
///   title: 'Delete Item',
///   content: 'Are you sure you want to delete this item?',
///   actions: [
///     AppButton.text(text: 'Cancel', onPressed: () => Navigator.pop(context)),
///     AppButton(text: 'Delete', onPressed: () {}),
///   ],
/// )
/// ```
class AppDialog {
  /// Shows a standard dialog
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    Widget? content,
    String? contentText,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _AppDialogWidget(
        title: title,
        content: content ?? (contentText != null ? Text(contentText) : null),
        actions: actions,
      ),
    );
  }

  /// Shows a confirmation dialog (Yes/No)
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
  }) async {
    final result = await show<bool>(
      context,
      title: title,
      contentText: message,
      actions: [
        AppButton.text(
          text: cancelText,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppButton(
          text: confirmText,
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm?.call();
          },
        ),
      ],
    );
    return result ?? false;
  }

  /// Shows a delete confirmation dialog
  static Future<bool> confirmDelete(
    BuildContext context, {
    required String title,
    required String message,
    String deleteText = 'Delete',
    String cancelText = 'Cancel',
    VoidCallback? onDelete,
  }) async {
    final theme = Theme.of(context);
    final result = await show<bool>(
      context,
      title: title,
      contentText: message,
      actions: [
        AppButton.text(
          text: cancelText,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppButton(
          text: deleteText,
          backgroundColor: theme.colorScheme.error,
          onPressed: () {
            Navigator.of(context).pop(true);
            onDelete?.call();
          },
        ),
      ],
    );
    return result ?? false;
  }

  /// Shows an alert dialog with a single OK button
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String message,
    String okText = 'OK',
  }) {
    return show(
      context,
      title: title,
      contentText: message,
      actions: [
        AppButton(text: okText, onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }

  /// Shows a loading dialog
  static void showLoading(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Dialog(
          child: Padding(
            padding: AppSpacing.paddingLG,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(width: AppSpacing.lg),
                  Text(message),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Hides the loading dialog
  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class _AppDialogWidget extends StatefulWidget {
  const _AppDialogWidget({this.title, this.content, this.actions});

  final String? title;
  final Widget? content;
  final List<Widget>? actions;

  @override
  State<_AppDialogWidget> createState() => _AppDialogWidgetState();
}

class _AppDialogWidgetState extends State<_AppDialogWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.modalDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.modalCurve),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AlertDialog(
          title: widget.title != null
              ? Text(widget.title!, style: theme.textTheme.headlineSmall)
              : null,
          content: widget.content,
          actions: widget.actions,
          actionsPadding: const EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.md,
          ),
          contentPadding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: widget.title != null ? AppSpacing.md : AppSpacing.lg,
            bottom: AppSpacing.md,
          ),
        ),
      ),
    );
  }
}

/// Custom dialog with more flexibility
///
/// Example usage:
/// ```dart
/// AppCustomDialog.show(
///   context,
///   child: Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       Icon(Icons.celebration, size: 64),
///       SizedBox(height: 16),
///       Text('Success!'),
///     ],
///   ),
/// )
/// ```
class AppCustomDialog {
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
    Color? backgroundColor,
    EdgeInsets? padding,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _CustomDialogWidget(
        backgroundColor: backgroundColor,
        padding: padding ?? AppSpacing.dialogPadding,
        child: child,
      ),
    );
  }
}

class _CustomDialogWidget extends StatefulWidget {
  const _CustomDialogWidget({
    required this.child,
    this.backgroundColor,
    required this.padding,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets padding;

  @override
  State<_CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<_CustomDialogWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.modalDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.modalCurve),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Dialog(
          backgroundColor: widget.backgroundColor,
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );
  }
}
