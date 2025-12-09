import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import 'app_button.dart';

/// Icon-only button with circular shape
///
/// Example usage:
/// ```dart
/// AppIconButton(
///   icon: Icons.favorite,
///   onPressed: () => print('Liked'),
/// )
///
/// AppIconButton.outlined(
///   icon: Icons.share,
///   onPressed: () => share(),
/// )
/// ```
class AppIconButton extends StatefulWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppIconButtonVariant.standard,
    this.size = AppButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
  });

  const AppIconButton.filled({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
  }) : variant = AppIconButtonVariant.filled;

  const AppIconButton.outlined({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.foregroundColor,
    this.tooltip,
  }) : variant = AppIconButtonVariant.outlined,
       backgroundColor = null;

  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final AppButtonSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
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
    if (widget.onPressed != null) {
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

    final iconSize = _getIconSize();
    final buttonSize = _getButtonSize();

    Widget button;

    switch (widget.variant) {
      case AppIconButtonVariant.standard:
        button = IconButton(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: iconSize),
          color: widget.foregroundColor,
          style: IconButton.styleFrom(
            minimumSize: Size(buttonSize, buttonSize),
            maximumSize: Size(buttonSize, buttonSize),
          ),
        );
        break;

      case AppIconButtonVariant.filled:
        button = IconButton.filled(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: iconSize),
          color: widget.foregroundColor,
          style: IconButton.styleFrom(
            backgroundColor: widget.backgroundColor,
            minimumSize: Size(buttonSize, buttonSize),
            maximumSize: Size(buttonSize, buttonSize),
          ),
        );
        break;

      case AppIconButtonVariant.outlined:
        button = IconButton.outlined(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: iconSize),
          color: widget.foregroundColor,
          style: IconButton.styleFrom(
            side: BorderSide(color: colorScheme.outline),
            minimumSize: Size(buttonSize, buttonSize),
            maximumSize: Size(buttonSize, buttonSize),
          ),
        );
        break;
    }

    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }

    if (widget.onPressed != null) {
      button = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: ScaleTransition(scale: _scaleAnimation, child: button),
      );
    }

    return button;
  }

  double _getIconSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 18;
      case AppButtonSize.medium:
        return 22;
      case AppButtonSize.large:
        return 26;
    }
  }

  double _getButtonSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }
}

enum AppIconButtonVariant { standard, filled, outlined }
