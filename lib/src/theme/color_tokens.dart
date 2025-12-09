import 'package:flutter/material.dart';

/// Core color tokens for the edu_ui_kit design system.
///
/// Provides a flexible color palette that can be customized while maintaining
/// semantic color naming and accessibility compliance.
///
/// Example usage:
/// ```dart
/// final colors = ColorTokens();
/// Container(color: colors.primary);
///
/// // Or with custom colors:
/// final customColors = ColorTokens(
///   primary: Color(0xFF1976D2),
///   secondary: Color(0xFFE91E63),
/// );
/// ```
class ColorTokens {
  /// Creates color tokens with optional custom colors.
  ///
  /// If colors are not provided, uses the default purple-blue gradient theme.
  ColorTokens({
    Color? primary,
    Color? secondary,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) : primary = primary ?? const Color(0xFF667eea),
       secondary = secondary ?? const Color(0xFF764ba2),
       success = success ?? const Color(0xFF10b981),
       warning = warning ?? const Color(0xFFf59e0b),
       error = error ?? const Color(0xFFef4444),
       info = info ?? const Color(0xFF3b82f6);

  /// Primary brand color - default: #667eea (purple-blue)
  final Color primary;

  /// Secondary brand color - default: #764ba2 (purple)
  final Color secondary;

  /// Success state color - default: #10b981 (green)
  final Color success;

  /// Warning state color - default: #f59e0b (amber)
  final Color warning;

  /// Error state color - default: #ef4444 (red)
  final Color error;

  /// Info state color - default: #3b82f6 (blue)
  final Color info;

  // Neutral colors for light theme
  static const Color neutralLight50 = Color(0xFFfafafa);
  static const Color neutralLight100 = Color(0xFFf5f5f5);
  static const Color neutralLight200 = Color(0xFFe5e5e5);
  static const Color neutralLight300 = Color(0xFFd4d4d4);
  static const Color neutralLight400 = Color(0xFFa3a3a3);
  static const Color neutralLight500 = Color(0xFF737373);
  static const Color neutralLight600 = Color(0xFF525252);
  static const Color neutralLight700 = Color(0xFF404040);
  static const Color neutralLight800 = Color(0xFF262626);
  static const Color neutralLight900 = Color(0xFF171717);

  // Neutral colors for dark theme
  static const Color neutralDark50 = Color(0xFF18181b);
  static const Color neutralDark100 = Color(0xFF27272a);
  static const Color neutralDark200 = Color(0xFF3f3f46);
  static const Color neutralDark300 = Color(0xFF52525b);
  static const Color neutralDark400 = Color(0xFF71717a);
  static const Color neutralDark500 = Color(0xFFa1a1aa);
  static const Color neutralDark600 = Color(0xFFd4d4d8);
  static const Color neutralDark700 = Color(0xFFe4e4e7);
  static const Color neutralDark800 = Color(0xFFf4f4f5);
  static const Color neutralDark900 = Color(0xFFfafafa);

  /// Generates tonal variants of a color for Material 3 color scheme
  static Map<int, Color> generateTonalPalette(Color color) {
    final hsl = HSLColor.fromColor(color);
    return {
      0: Colors.black,
      10: hsl.withLightness(0.10).toColor(),
      20: hsl.withLightness(0.20).toColor(),
      30: hsl.withLightness(0.30).toColor(),
      40: hsl.withLightness(0.40).toColor(),
      50: hsl.withLightness(0.50).toColor(),
      60: hsl.withLightness(0.60).toColor(),
      70: hsl.withLightness(0.70).toColor(),
      80: hsl.withLightness(0.80).toColor(),
      90: hsl.withLightness(0.90).toColor(),
      95: hsl.withLightness(0.95).toColor(),
      99: hsl.withLightness(0.99).toColor(),
      100: Colors.white,
    };
  }

  /// Creates a Material 3 color scheme for light theme
  ColorScheme toLightColorScheme() {
    return ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: _lighten(primary, 0.8),
      onPrimaryContainer: _darken(primary, 0.8),
      secondary: secondary,
      onSecondary: Colors.white,
      secondaryContainer: _lighten(secondary, 0.8),
      onSecondaryContainer: _darken(secondary, 0.8),
      tertiary: info,
      onTertiary: Colors.white,
      tertiaryContainer: _lighten(info, 0.8),
      onTertiaryContainer: _darken(info, 0.8),
      error: error,
      onError: Colors.white,
      errorContainer: _lighten(error, 0.8),
      onErrorContainer: _darken(error, 0.8),
      surface: neutralLight50,
      onSurface: neutralLight900,
      surfaceContainerHighest: neutralLight100,
      onSurfaceVariant: neutralLight700,
      outline: neutralLight300,
      outlineVariant: neutralLight200,
      shadow: Colors.black.withValues(alpha: 0.1),
      scrim: Colors.black.withValues(alpha: 0.5),
      inverseSurface: neutralLight800,
      onInverseSurface: neutralLight50,
      inversePrimary: _lighten(primary, 0.6),
    );
  }

  /// Creates a Material 3 color scheme for dark theme
  ColorScheme toDarkColorScheme() {
    return ColorScheme.dark(
      primary: _lighten(primary, 0.3),
      onPrimary: _darken(primary, 0.8),
      primaryContainer: _darken(primary, 0.6),
      onPrimaryContainer: _lighten(primary, 0.8),
      secondary: _lighten(secondary, 0.3),
      onSecondary: _darken(secondary, 0.8),
      secondaryContainer: _darken(secondary, 0.6),
      onSecondaryContainer: _lighten(secondary, 0.8),
      tertiary: _lighten(info, 0.3),
      onTertiary: _darken(info, 0.8),
      tertiaryContainer: _darken(info, 0.6),
      onTertiaryContainer: _lighten(info, 0.8),
      error: _lighten(error, 0.3),
      onError: _darken(error, 0.8),
      errorContainer: _darken(error, 0.6),
      onErrorContainer: _lighten(error, 0.8),
      surface: neutralDark50,
      onSurface: neutralDark900,
      surfaceContainerHighest: neutralDark100,
      onSurfaceVariant: neutralDark700,
      outline: neutralDark300,
      outlineVariant: neutralDark200,
      shadow: Colors.black.withValues(alpha: 0.3),
      scrim: Colors.black.withValues(alpha: 0.7),
      inverseSurface: neutralDark800,
      onInverseSurface: neutralDark50,
      inversePrimary: primary,
    );
  }

  /// Lightens a color by a given amount (0.0 to 1.0)
  static Color _lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount * (1.0 - hsl.lightness)).clamp(
      0.0,
      1.0,
    );
    return hsl.withLightness(lightness).toColor();
  }

  /// Darkens a color by a given amount (0.0 to 1.0)
  static Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness * (1.0 - amount)).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}

/// Extension on ColorScheme to add semantic colors
extension ColorSchemeExtension on ColorScheme {
  /// Success color for positive actions and states
  Color get success => const Color(0xFF10b981);

  /// On-success color (text/icons on success color)
  Color get onSuccess => Colors.white;

  /// Success container color
  Color get successContainer => const Color(0xFFd1fae5);

  /// On-success-container color
  Color get onSuccessContainer => const Color(0xFF065f46);

  /// Warning color for cautionary actions and states
  Color get warning => const Color(0xFFf59e0b);

  /// On-warning color (text/icons on warning color)
  Color get onWarning => Colors.white;

  /// Warning container color
  Color get warningContainer => const Color(0xFFfef3c7);

  /// On-warning-container color
  Color get onWarningContainer => const Color(0xFF92400e);

  /// Info color for informational actions and states
  Color get info => const Color(0xFF3b82f6);

  /// On-info color (text/icons on info color)
  Color get onInfo => Colors.white;

  /// Info container color
  Color get infoContainer => const Color(0xFFdbeafe);

  /// On-info-container color
  Color get onInfoContainer => const Color(0xFF1e3a8a);
}
