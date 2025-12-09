import 'package:flutter/material.dart';

/// Typography system for edu_ui_kit following Material Design 3 text styles.
///
/// Supports both custom fonts and system default fonts. Use [AppTypography.create]
/// to generate a complete text theme with your preferred font family.
///
/// Example usage:
/// ```dart
/// // With custom font
/// final textTheme = AppTypography.create(fontFamily: 'PlusJakartaSans');
///
/// // With system default
/// final textTheme = AppTypography.create();
///
/// // In your app
/// Text('Hello', style: Theme.of(context).textTheme.headlineLarge);
/// ```
class AppTypography {
  /// Creates a complete Material 3 text theme with optional custom font family.
  ///
  /// If [fontFamily] is not provided, uses the system default font (Roboto on Android, SF Pro on iOS).
  ///
  /// Parameters:
  /// - [fontFamily]: Optional font family name (must be added to pubspec.yaml in your app)
  /// - [baseColor]: Base text color, defaults to null (uses theme color)
  static TextTheme create({String? fontFamily, Color? baseColor}) {
    return TextTheme(
      // Display styles - largest text
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
        color: baseColor,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
        color: baseColor,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
        color: baseColor,
      ),

      // Headline styles - high-emphasis text
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.25,
        color: baseColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.29,
        color: baseColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.33,
        color: baseColor,
      ),

      // Title styles - medium-emphasis text
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
        color: baseColor,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.50,
        color: baseColor,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: baseColor,
      ),

      // Body styles - main content text
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.50,
        color: baseColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: baseColor,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: baseColor,
      ),

      // Label styles - buttons, tabs, and other UI elements
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: baseColor,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
        color: baseColor,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: baseColor,
      ),
    );
  }

  /// Common font weights for easy reference
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

/// Extension on TextTheme to add custom utility methods
extension TextThemeExtension on TextTheme {
  /// Returns a text style with the given color
  TextStyle withColor(TextStyle? style, Color color) {
    return style?.copyWith(color: color) ?? TextStyle(color: color);
  }

  /// Returns a text style with increased font weight
  TextStyle makeBold(TextStyle? style) {
    return style?.copyWith(fontWeight: FontWeight.w700) ??
        const TextStyle(fontWeight: FontWeight.w700);
  }

  /// Returns a text style with custom letter spacing
  TextStyle withLetterSpacing(TextStyle? style, double spacing) {
    return style?.copyWith(letterSpacing: spacing) ??
        TextStyle(letterSpacing: spacing);
  }
}

/// Recommended Google Fonts for education apps
///
/// These fonts work well for education platforms and can be added to your app:
///
/// **Plus Jakarta Sans** - Modern, friendly, excellent readability
/// ```yaml
/// dependencies:
///   google_fonts: ^6.1.0
/// ```
/// ```dart
/// textTheme: AppTypography.create(fontFamily: GoogleFonts.plusJakartaSans().fontFamily)
/// ```
///
/// **Inter** - Clean, professional, great for data-heavy interfaces
/// ```dart
/// textTheme: AppTypography.create(fontFamily: GoogleFonts.inter().fontFamily)
/// ```
///
/// **Manrope** - Balanced, geometric, works well for headings
/// ```dart
/// textTheme: AppTypography.create(fontFamily: GoogleFonts.manrope().fontFamily)
/// ```
///
/// **Poppins** - Playful, rounded, good for student-facing apps
/// ```dart
/// textTheme: AppTypography.create(fontFamily: GoogleFonts.poppins().fontFamily)
/// ```
class RecommendedFonts {
  static const String plusJakartaSans = 'PlusJakartaSans';
  static const String inter = 'Inter';
  static const String manrope = 'Manrope';
  static const String poppins = 'Poppins';
  static const String spaceGrotesk = 'Space Grotesk';
}
