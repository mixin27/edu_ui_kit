import 'package:flutter/material.dart';

/// Animation duration and curve constants for consistent motion design.
///
/// Provides standardized animation timings and curves following Material Design
/// motion principles for a cohesive user experience.
///
/// Example usage:
/// ```dart
/// AnimatedContainer(
///   duration: AppAnimations.durationMedium,
///   curve: AppAnimations.curveEaseInOut,
///   color: Colors.blue,
/// )
///
/// TweenAnimationBuilder(
///   duration: AppAnimations.durationFast,
///   curve: AppAnimations.curveSpring,
///   tween: Tween<double>(begin: 0, end: 1),
///   builder: (context, value, child) => ...,
/// )
/// ```
class AppAnimations {
  // Duration constants
  /// Very fast animation - 100ms (micro-interactions like ripples)
  static const Duration durationInstant = Duration(milliseconds: 100);

  /// Fast animation - 200ms (button presses, switches)
  static const Duration durationFast = Duration(milliseconds: 200);

  /// Medium animation - 300ms (most common, cards, containers)
  static const Duration durationMedium = Duration(milliseconds: 300);

  /// Slow animation - 400ms (page transitions, modals)
  static const Duration durationSlow = Duration(milliseconds: 400);

  /// Very slow animation - 500ms (complex transitions)
  static const Duration durationVerySlow = Duration(milliseconds: 500);

  // Standard Material Design curves
  /// Standard easing curve - smooth start and end
  static const Curve curveStandard = Curves.easeInOut;

  /// Emphasized easing - quick start, slow end (entering elements)
  static const Curve curveEmphasized = Curves.easeOut;

  /// Decelerated easing - slow start, quick end (exiting elements)
  static const Curve curveDecelerated = Curves.easeIn;

  /// Linear - constant speed (progress indicators)
  static const Curve curveLinear = Curves.linear;

  // Custom curves for specific use cases
  /// Ease in out curve - smooth animation
  static const Curve curveEaseInOut = Curves.easeInOut;

  /// Ease out curve - starts fast, ends slow (good for elements entering)
  static const Curve curveEaseOut = Curves.easeOut;

  /// Ease in curve - starts slow, ends fast (good for elements exiting)
  static const Curve curveEaseIn = Curves.easeIn;

  /// Spring curve - bouncy effect
  static const Curve curveSpring = Curves.elasticOut;

  /// Overshoot curve - slight bounce at end
  static const Curve curveOvershoot = Curves.easeOutBack;

  /// Anticipate curve - slight pull back before moving
  static const Curve curveAnticipate = Curves.easeInBack;

  // Common animation combinations
  /// Quick fade in - 200ms with ease out
  static const Duration fadeInDuration = durationFast;
  static const Curve fadeInCurve = curveEaseOut;

  /// Fade out - 200ms with ease in
  static const Duration fadeOutDuration = durationFast;
  static const Curve fadeOutCurve = curveEaseIn;

  /// Scale animation - 300ms with ease in out
  static const Duration scaleDuration = durationMedium;
  static const Curve scaleCurve = curveEaseInOut;

  /// Slide animation - 300ms with emphasized
  static const Duration slideDuration = durationMedium;
  static const Curve slideCurve = curveEmphasized;

  /// Page transition - 400ms with ease in out
  static const Duration pageTransitionDuration = durationSlow;
  static const Curve pageTransitionCurve = curveEaseInOut;

  /// Modal/Dialog transition - 300ms with ease out
  static const Duration modalDuration = durationMedium;
  static const Curve modalCurve = curveEaseOut;

  /// Button press animation - 100ms with ease out
  static const Duration buttonPressDuration = durationInstant;
  static const Curve buttonPressCurve = curveEaseOut;

  /// Shimmer loading - 1500ms linear
  static const Duration shimmerDuration = Duration(milliseconds: 1500);
  static const Curve shimmerCurve = curveLinear;
}

/// Utility class for creating common animations
class AnimationUtils {
  /// Creates a fade transition
  static Widget fadeTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(opacity: animation, child: child);
  }

  /// Creates a scale transition
  static Widget scaleTransition({
    required Widget child,
    required Animation<double> animation,
    Alignment alignment = Alignment.center,
  }) {
    return ScaleTransition(
      scale: animation,
      alignment: alignment,
      child: child,
    );
  }

  /// Creates a slide transition
  static Widget slideTransition({
    required Widget child,
    required Animation<double> animation,
    Offset beginOffset = const Offset(0, 1),
    Offset endOffset = Offset.zero,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: endOffset,
      ).animate(animation),
      child: child,
    );
  }

  /// Creates a fade + scale transition (nice for dialogs/modals)
  static Widget fadeScaleTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: AppAnimations.curveEaseOut),
        ),
        child: child,
      ),
    );
  }

  /// Creates a slide + fade transition (nice for page transitions)
  static Widget slideFadeTransition({
    required Widget child,
    required Animation<double> animation,
    Offset beginOffset = const Offset(1, 0),
  }) {
    return SlideTransition(
      position: Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
        CurvedAnimation(
          parent: animation,
          curve: AppAnimations.curveEmphasized,
        ),
      ),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  /// Creates a custom page route with slide transition
  static PageRoute<T> createSlideRoute<T>({
    required Widget child,
    RouteSettings? settings,
    SlideDirection direction = SlideDirection.fromRight,
  }) {
    Offset getBeginOffset() {
      switch (direction) {
        case SlideDirection.fromRight:
          return const Offset(1, 0);
        case SlideDirection.fromLeft:
          return const Offset(-1, 0);
        case SlideDirection.fromTop:
          return const Offset(0, -1);
        case SlideDirection.fromBottom:
          return const Offset(0, 1);
      }
    }

    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: AppAnimations.pageTransitionDuration,
      reverseTransitionDuration: AppAnimations.pageTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: AppAnimations.pageTransitionCurve,
                ),
              ),
          child: child,
        );
      },
    );
  }

  /// Creates a custom page route with fade transition
  static PageRoute<T> createFadeRoute<T>({
    required Widget child,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: AppAnimations.pageTransitionDuration,
      reverseTransitionDuration: AppAnimations.pageTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// Creates a custom modal route with scale + fade transition
  static PageRoute<T> createModalRoute<T>({
    required Widget child,
    RouteSettings? settings,
    bool barrierDismissible = true,
    Color barrierColor = Colors.black54,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      opaque: false,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: AppAnimations.modalDuration,
      reverseTransitionDuration: AppAnimations.modalDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return fadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}

/// Slide direction for page transitions
enum SlideDirection { fromRight, fromLeft, fromTop, fromBottom }

/// Stagger animation helper for list items
class StaggeredAnimationHelper {
  /// Creates staggered animations for list items
  ///
  /// Example usage:
  /// ```dart
  /// ListView.builder(
  ///   itemCount: items.length,
  ///   itemBuilder: (context, index) {
  ///     return StaggeredAnimationHelper.createStaggeredAnimation(
  ///       index: index,
  ///       child: ListTile(...),
  ///     );
  ///   },
  /// )
  /// ```
  static Widget createStaggeredAnimation({
    required int index,
    required Widget child,
    Duration delay = const Duration(milliseconds: 50),
    Duration duration = AppAnimations.durationMedium,
    Curve curve = AppAnimations.curveEaseOut,
    Offset slideOffset = const Offset(0, 0.1),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration + (delay * index),
      curve: curve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            slideOffset.dx * (1 - value),
            slideOffset.dy * (1 - value),
          ),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }
}
