import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import '../../theme/spacing.dart';

/// A versatile button component with multiple variants and built-in animations.
///
/// Supports various styles: filled, outlined, text, and elevated variants.
/// Includes loading states, icon support, and smooth animations.
///
/// Example usage:
/// ```dart
/// AppButton(
///   text: 'Submit',
///   onPressed: () => print('Pressed'),
/// )
///
/// AppButton.outlined(
///   text: 'Cancel',
///   onPressed: () => Navigator.pop(context),
///   icon: Icons.close,
/// )
///
/// AppButton(
///   text: 'Loading',
///   isLoading: true,
///   onPressed: () {},
/// )
/// ```
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.variant = AppButtonVariant.filled,
    this.size = AppButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  /// Creates a filled button (default style)
  const AppButton.filled({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.size = AppButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
  }) : variant = AppButtonVariant.filled,
       borderColor = null;

  /// Creates an outlined button
  const AppButton.outlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.size = AppButtonSize.medium,
    this.foregroundColor,
    this.borderColor,
  }) : variant = AppButtonVariant.outlined,
       backgroundColor = null;

  /// Creates a text button (no background)
  const AppButton.text({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.size = AppButtonSize.medium,
    this.foregroundColor,
  }) : variant = AppButtonVariant.text,
       backgroundColor = null,
       borderColor = null;

  /// Creates an elevated button with shadow
  const AppButton.elevated({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.size = AppButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
  }) : variant = AppButtonVariant.elevated,
       borderColor = null;

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: AppAnimations.buttonPressDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: AppAnimations.buttonPressCurve,
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _scaleController.reverse();
  }

  void _handleTapCancel() {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final buttonSize = _getButtonSize();
    final isDisabled = widget.onPressed == null || widget.isLoading;

    Widget button;

    switch (widget.variant) {
      case AppButtonVariant.filled:
        button = FilledButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: widget.backgroundColor,
            foregroundColor: widget.foregroundColor,
            minimumSize: Size(buttonSize.minWidth, buttonSize.height),
            padding: buttonSize.padding,
            disabledBackgroundColor: colorScheme.onSurface.withValues(
              alpha: 0.12,
            ),
            disabledForegroundColor: colorScheme.onSurface.withValues(
              alpha: 0.38,
            ),
          ),
          child: _buildButtonContent(context),
        );
        break;

      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style:
              OutlinedButton.styleFrom(
                foregroundColor: widget.foregroundColor,
                side: BorderSide(
                  color: widget.borderColor ?? colorScheme.outline,
                ),
                minimumSize: Size(buttonSize.minWidth, buttonSize.height),
                padding: buttonSize.padding,
                disabledForegroundColor: colorScheme.onSurface.withValues(
                  alpha: 0.38,
                ),
              ).copyWith(
                side: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return BorderSide(
                      color: colorScheme.onSurface.withValues(alpha: 0.12),
                    );
                  }
                  return BorderSide(
                    color: widget.borderColor ?? colorScheme.outline,
                  );
                }),
              ),
          child: _buildButtonContent(context),
        );
        break;

      case AppButtonVariant.text:
        button = TextButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: TextButton.styleFrom(
            foregroundColor: widget.foregroundColor,
            minimumSize: Size(buttonSize.minWidth, buttonSize.height),
            padding: buttonSize.padding,
            disabledForegroundColor: colorScheme.onSurface.withValues(
              alpha: 0.38,
            ),
          ),
          child: _buildButtonContent(context),
        );
        break;

      case AppButtonVariant.elevated:
        button = ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor,
            foregroundColor: widget.foregroundColor,
            elevation: 2,
            minimumSize: Size(buttonSize.minWidth, buttonSize.height),
            padding: buttonSize.padding,
            disabledBackgroundColor: colorScheme.onSurface.withValues(
              alpha: 0.12,
            ),
            disabledForegroundColor: colorScheme.onSurface.withValues(
              alpha: 0.38,
            ),
          ),
          child: _buildButtonContent(context),
        );
        break;
    }

    Widget result = button;

    if (widget.isFullWidth) {
      result = SizedBox(width: double.infinity, child: result);
    }

    // Add scale animation on press
    if (!isDisabled) {
      result = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: ScaleTransition(scale: _scaleAnimation, child: result),
      );
    }

    return result;
  }

  Widget _buildButtonContent(BuildContext context) {
    if (widget.isLoading) {
      return SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    }

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: _getIconSize()),
          const SizedBox(width: AppSpacing.xs),
          Text(widget.text),
        ],
      );
    }

    return Text(widget.text);
  }

  _ButtonSize _getButtonSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return _ButtonSize(
          height: 36,
          minWidth: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
        );
      case AppButtonSize.medium:
        return _ButtonSize(
          height: 48,
          minWidth: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
        );
      case AppButtonSize.large:
        return _ButtonSize(
          height: 56,
          minWidth: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
        );
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 18;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }
}

/// Button variant types
enum AppButtonVariant { filled, outlined, text, elevated }

/// Button size options
enum AppButtonSize { small, medium, large }

class _ButtonSize {
  final double height;
  final double minWidth;
  final EdgeInsets padding;

  _ButtonSize({
    required this.height,
    required this.minWidth,
    required this.padding,
  });
}
