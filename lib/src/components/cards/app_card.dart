import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import '../../theme/spacing.dart';

/// A versatile card component with elevation, borders, and interactive states.
///
/// Supports various styles and includes smooth hover/tap animations.
///
/// Example usage:
/// ```dart
/// AppCard(
///   child: Text('Card content'),
/// )
///
/// AppCard.elevated(
///   onTap: () => print('Tapped'),
///   child: ListTile(title: Text('Clickable card')),
/// )
///
/// AppCard.outlined(
///   padding: AppSpacing.paddingLG,
///   child: Column(children: [...]),
/// )
/// ```
class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = AppSpacing.cardPadding,
    this.margin,
    this.variant = AppCardVariant.elevated,
    this.backgroundColor,
    this.borderColor,
    this.elevation,
    this.width,
    this.height,
  });

  /// Creates an elevated card with shadow
  const AppCard.elevated({
    super.key,
    required this.child,
    this.onTap,
    this.padding = AppSpacing.cardPadding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.width,
    this.height,
  }) : variant = AppCardVariant.elevated,
       borderColor = null;

  /// Creates an outlined card with border
  const AppCard.outlined({
    super.key,
    required this.child,
    this.onTap,
    this.padding = AppSpacing.cardPadding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  }) : variant = AppCardVariant.outlined,
       elevation = null;

  /// Creates a filled card with background color
  const AppCard.filled({
    super.key,
    required this.child,
    this.onTap,
    this.padding = AppSpacing.cardPadding,
    this.margin,
    this.backgroundColor,
    this.width,
    this.height,
  }) : variant = AppCardVariant.filled,
       borderColor = null,
       elevation = null;

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final AppCardVariant variant;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final double? width;
  final double? height;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: AppAnimations.durationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: AppAnimations.curveEaseOut,
      ),
    );
    _elevationAnimation = Tween<double>(begin: 0.0, end: 4.0).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: AppAnimations.curveEaseOut,
      ),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _handleHoverEnter(PointerEvent event) {
    if (widget.onTap != null) {
      setState(() => _isHovered = true);
      _hoverController.forward();
    }
  }

  void _handleHoverExit(PointerEvent event) {
    setState(() => _isHovered = false);
    _hoverController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isInteractive = widget.onTap != null;

    Widget card = Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: _buildDecoration(colorScheme),
      child: ClipRRect(
        borderRadius: AppRadius.cardRadius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: AppRadius.cardRadius,
            child: Padding(padding: widget.padding, child: widget.child),
          ),
        ),
      ),
    );

    if (isInteractive) {
      card = MouseRegion(
        onEnter: _handleHoverEnter,
        onExit: _handleHoverExit,
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.scale(scale: _scaleAnimation.value, child: child);
          },
          child: card,
        ),
      );
    }

    return card;
  }

  BoxDecoration _buildDecoration(ColorScheme colorScheme) {
    final baseColor = widget.backgroundColor ?? colorScheme.surface;

    switch (widget.variant) {
      case AppCardVariant.elevated:
        final elevation = _isHovered ? _elevationAnimation.value : 0.0;
        return BoxDecoration(
          color: baseColor,
          borderRadius: AppRadius.cardRadius,
          boxShadow: AppElevation.getShadow(
            elevation + (_isHovered ? 4.0 : 2.0),
            opacity: 0.1,
          ),
        );

      case AppCardVariant.outlined:
        return BoxDecoration(
          color: baseColor,
          borderRadius: AppRadius.cardRadius,
          border: Border.all(
            color:
                widget.borderColor ??
                colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        );

      case AppCardVariant.filled:
        return BoxDecoration(
          color: widget.backgroundColor ?? colorScheme.surfaceContainerHighest,
          borderRadius: AppRadius.cardRadius,
        );
    }
  }
}

enum AppCardVariant { elevated, outlined, filled }
