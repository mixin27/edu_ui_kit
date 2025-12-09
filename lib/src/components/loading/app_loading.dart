import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import '../../theme/spacing.dart';

/// A circular loading indicator with optional text
///
/// Example usage:
/// ```dart
/// AppLoadingIndicator()
///
/// AppLoadingIndicator.small()
///
/// AppLoadingIndicator(
///   size: AppLoadingSize.large,
///   text: 'Loading...',
/// )
/// ```
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = AppLoadingSize.medium,
    this.color,
    this.text,
  });

  const AppLoadingIndicator.small({super.key, this.color, this.text})
    : size = AppLoadingSize.small;

  const AppLoadingIndicator.large({super.key, this.color, this.text})
    : size = AppLoadingSize.large;

  final AppLoadingSize size;
  final Color? color;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final indicatorSize = _getSize();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: indicatorSize,
            height: indicatorSize,
            child: CircularProgressIndicator(
              color: color ?? colorScheme.primary,
              strokeWidth: _getStrokeWidth(),
            ),
          ),
          if (text != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              text!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  double _getSize() {
    switch (size) {
      case AppLoadingSize.small:
        return 24;
      case AppLoadingSize.medium:
        return 40;
      case AppLoadingSize.large:
        return 56;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case AppLoadingSize.small:
        return 2.5;
      case AppLoadingSize.medium:
        return 3.5;
      case AppLoadingSize.large:
        return 4.5;
    }
  }
}

enum AppLoadingSize { small, medium, large }

/// A linear progress indicator
///
/// Example usage:
/// ```dart
/// AppProgressBar(value: 0.7)
///
/// AppProgressBar() // Indeterminate
/// ```
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.height = 4.0,
  });

  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: value,
          color: color ?? colorScheme.primary,
          backgroundColor:
              backgroundColor ?? colorScheme.surfaceContainerHighest,
        ),
      ),
    );
  }
}

/// A shimmer loading effect for content placeholders
///
/// Example usage:
/// ```dart
/// AppShimmer(
///   child: Container(
///     width: 200,
///     height: 20,
///     decoration: BoxDecoration(
///       color: Colors.white,
///       borderRadius: BorderRadius.circular(4),
///     ),
///   ),
/// )
/// ```
class AppShimmer extends StatefulWidget {
  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration = AppAnimations.shimmerDuration,
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final baseColor =
        widget.baseColor ??
        (isDark
            ? colorScheme.surfaceContainerHighest
            : colorScheme.surfaceContainerHighest);
    final highlightColor =
        widget.highlightColor ??
        (isDark
            ? colorScheme.surface.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.6));

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Pre-built shimmer skeleton for list items
///
/// Example usage:
/// ```dart
/// ListView.builder(
///   itemCount: 5,
///   itemBuilder: (context, index) => AppListItemSkeleton(),
/// )
/// ```
class AppListItemSkeleton extends StatelessWidget {
  const AppListItemSkeleton({
    super.key,
    this.showAvatar = true,
    this.lines = 2,
  });

  final bool showAvatar;
  final int lines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: AppSpacing.listItemPadding,
      child: Row(
        children: [
          if (showAvatar) ...[
            AppShimmer(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: AppRadius.radiusSM,
                    ),
                  ),
                ),
                if (lines > 1)
                  for (int i = 1; i < lines; i++) ...[
                    const SizedBox(height: AppSpacing.xs),
                    AppShimmer(
                      child: Container(
                        height: 14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: AppRadius.radiusSM,
                        ),
                      ),
                    ),
                  ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pre-built shimmer skeleton for cards
///
/// Example usage:
/// ```dart
/// GridView.builder(
///   itemCount: 6,
///   itemBuilder: (context, index) => AppCardSkeleton(),
/// )
/// ```
class AppCardSkeleton extends StatelessWidget {
  const AppCardSkeleton({super.key, this.height = 220, this.showImage = true});

  final double height;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppRadius.cardRadius,
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showImage)
            AppShimmer(
              child: Container(
                height: height * 0.5,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.lg),
                    topRight: Radius.circular(AppRadius.lg),
                  ),
                ),
              ),
            ),
          Padding(
            padding: AppSpacing.paddingMD,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: AppRadius.radiusSM,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppShimmer(
                  child: Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: AppRadius.radiusSM,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                AppShimmer(
                  child: Container(
                    height: 16,
                    width: 150,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: AppRadius.radiusSM,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-screen loading overlay
///
/// Example usage:
/// ```dart
/// AppLoadingOverlay(
///   isLoading: true,
///   child: YourContent(),
/// )
/// ```
class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.text,
    this.color,
  });

  final bool isLoading;
  final Widget child;
  final String? text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: AppLoadingIndicator(text: text, color: color),
            ),
          ),
      ],
    );
  }
}
