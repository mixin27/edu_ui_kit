import 'package:flutter/material.dart';

/// Spacing system following an 8px base unit grid.
///
/// Provides consistent spacing values throughout the app. All values are
/// multiples of 4 for better alignment and visual rhythm.
///
/// Example usage:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(AppSpacing.md),
///   child: Container(),
/// )
///
/// SizedBox(height: AppSpacing.lg)
///
/// EdgeInsets.symmetric(
///   horizontal: AppSpacing.md,
///   vertical: AppSpacing.sm,
/// )
/// ```
class AppSpacing {
  /// Extra extra small spacing - 4px
  static const double xxs = 4.0;

  /// Extra small spacing - 8px
  static const double xs = 8.0;

  /// Small spacing - 12px
  static const double sm = 12.0;

  /// Medium spacing - 16px (most common)
  static const double md = 16.0;

  /// Large spacing - 24px
  static const double lg = 24.0;

  /// Extra large spacing - 32px
  static const double xl = 32.0;

  /// Extra extra large spacing - 48px
  static const double xxl = 48.0;

  /// Extra extra extra large spacing - 64px
  static const double xxxl = 64.0;

  // Common padding presets
  /// Zero padding
  static const EdgeInsets paddingZero = EdgeInsets.zero;

  /// Extra small padding - 8px all sides
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);

  /// Small padding - 12px all sides
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);

  /// Medium padding - 16px all sides
  static const EdgeInsets paddingMD = EdgeInsets.all(md);

  /// Large padding - 24px all sides
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);

  /// Extra large padding - 32px all sides
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);

  /// Extra extra large padding - 48px all sides
  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);

  // Horizontal padding presets
  /// Small horizontal padding - 12px
  static const EdgeInsets paddingHorizontalSM = EdgeInsets.symmetric(
    horizontal: sm,
  );

  /// Medium horizontal padding - 16px
  static const EdgeInsets paddingHorizontalMD = EdgeInsets.symmetric(
    horizontal: md,
  );

  /// Large horizontal padding - 24px
  static const EdgeInsets paddingHorizontalLG = EdgeInsets.symmetric(
    horizontal: lg,
  );

  /// Extra large horizontal padding - 32px
  static const EdgeInsets paddingHorizontalXL = EdgeInsets.symmetric(
    horizontal: xl,
  );

  // Vertical padding presets
  /// Small vertical padding - 12px
  static const EdgeInsets paddingVerticalSM = EdgeInsets.symmetric(
    vertical: sm,
  );

  /// Medium vertical padding - 16px
  static const EdgeInsets paddingVerticalMD = EdgeInsets.symmetric(
    vertical: md,
  );

  /// Large vertical padding - 24px
  static const EdgeInsets paddingVerticalLG = EdgeInsets.symmetric(
    vertical: lg,
  );

  /// Extra large vertical padding - 32px
  static const EdgeInsets paddingVerticalXL = EdgeInsets.symmetric(
    vertical: xl,
  );

  // Common page/screen padding
  /// Standard page padding - 16px horizontal, 24px vertical
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: lg,
  );

  /// Page padding with safe area consideration
  static EdgeInsets pagePaddingWithSafeArea(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return EdgeInsets.only(
      left: md + padding.left,
      right: md + padding.right,
      top: lg + padding.top,
      bottom: lg + padding.bottom,
    );
  }

  /// Card content padding - 16px all sides
  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  /// List item padding - 16px horizontal, 12px vertical
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  /// Dialog padding - 24px all sides
  static const EdgeInsets dialogPadding = EdgeInsets.all(lg);

  /// Bottom sheet padding - 16px horizontal, 24px top, 32px bottom (for handle space)
  static const EdgeInsets bottomSheetPadding = EdgeInsets.fromLTRB(
    md,
    lg,
    md,
    xl,
  );
}

/// Border radius system for consistent rounded corners
class AppRadius {
  /// No radius - 0px
  static const double none = 0.0;

  /// Extra small radius - 4px
  static const double xs = 4.0;

  /// Small radius - 8px
  static const double sm = 8.0;

  /// Medium radius - 12px
  static const double md = 12.0;

  /// Large radius - 16px
  static const double lg = 16.0;

  /// Extra large radius - 20px
  static const double xl = 20.0;

  /// Extra extra large radius - 24px
  static const double xxl = 24.0;

  /// Full/circular radius - 9999px
  static const double full = 9999.0;

  // BorderRadius presets
  /// No border radius
  static const BorderRadius radiusNone = BorderRadius.zero;

  /// Extra small border radius - 4px
  static const BorderRadius radiusXS = BorderRadius.all(Radius.circular(xs));

  /// Small border radius - 8px
  static const BorderRadius radiusSM = BorderRadius.all(Radius.circular(sm));

  /// Medium border radius - 12px
  static const BorderRadius radiusMD = BorderRadius.all(Radius.circular(md));

  /// Large border radius - 16px
  static const BorderRadius radiusLG = BorderRadius.all(Radius.circular(lg));

  /// Extra large border radius - 20px
  static const BorderRadius radiusXL = BorderRadius.all(Radius.circular(xl));

  /// Extra extra large border radius - 24px
  static const BorderRadius radiusXXL = BorderRadius.all(Radius.circular(xxl));

  /// Full/circular border radius
  static const BorderRadius radiusFull = BorderRadius.all(
    Radius.circular(full),
  );

  // Common component radius
  /// Button border radius - 12px
  static const BorderRadius buttonRadius = radiusMD;

  /// Card border radius - 16px
  static const BorderRadius cardRadius = radiusLG;

  /// Input field border radius - 12px
  static const BorderRadius inputRadius = radiusMD;

  /// Dialog border radius - 20px
  static const BorderRadius dialogRadius = radiusXL;

  /// Bottom sheet border radius - 24px top corners only
  static const BorderRadius bottomSheetRadius = BorderRadius.only(
    topLeft: Radius.circular(xxl),
    topRight: Radius.circular(xxl),
  );

  /// Chip/tag border radius - full (pill shape)
  static const BorderRadius chipRadius = radiusFull;
}

/// Elevation/shadow system
class AppElevation {
  /// No elevation
  static const double none = 0.0;

  /// Small elevation - subtle depth
  static const double sm = 2.0;

  /// Medium elevation - standard depth
  static const double md = 4.0;

  /// Large elevation - prominent depth
  static const double lg = 8.0;

  /// Extra large elevation - very prominent depth
  static const double xl = 16.0;

  /// Gets a shadow for the given elevation level
  static List<BoxShadow> getShadow(
    double elevation, {
    Color? color,
    double opacity = 0.1,
  }) {
    if (elevation == none) return [];

    final shadowColor = color ?? Colors.black;

    return [
      BoxShadow(
        color: shadowColor.withValues(alpha: opacity),
        blurRadius: elevation * 2,
        offset: Offset(0, elevation / 2),
      ),
    ];
  }

  /// Soft shadow for cards and containers
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  /// Stronger shadow for elevated elements
  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];
}

/// Icon sizes
class AppIconSize {
  /// Extra small icon - 16px
  static const double xs = 16.0;

  /// Small icon - 20px
  static const double sm = 20.0;

  /// Medium icon - 24px (standard)
  static const double md = 24.0;

  /// Large icon - 32px
  static const double lg = 32.0;

  /// Extra large icon - 48px
  static const double xl = 48.0;

  /// Extra extra large icon - 64px
  static const double xxl = 64.0;
}
