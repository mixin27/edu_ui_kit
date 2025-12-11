/// A flexible and beautiful UI kit for education apps built on Material Design 3.
///
/// This package provides a comprehensive design system including:
/// - Flexible theming with Material 3 support
/// - Beautiful pre-built components with smooth animations
/// - Glassmorphic variants for premium look
/// - Education-specific widgets and patterns
/// - Consistent spacing, typography, and color systems
/// - Support for both custom fonts and system defaults
/// - Adaptive widgets for iOS and Android
///
/// ## Getting Started
///
/// Add the theme to your MaterialApp:
/// ```dart
/// import 'package:edu_ui_kit/edu_ui_kit.dart';
///
/// MaterialApp(
///   theme: AppTheme.lightTheme(),
///   darkTheme: AppTheme.darkTheme(),
///   themeMode: ThemeMode.system,
///   home: MyHomePage(),
/// )
/// ```
///
/// ## Customization
///
/// Customize colors:
/// ```dart
/// AppTheme.lightTheme(
///   colors: ColorTokens(
///     primary: Color(0xFF1976D2),
///     secondary: Color(0xFFE91E63),
///   ),
/// )
/// ```
///
/// Use custom fonts:
/// ```dart
/// AppTheme.lightTheme(
///   fontFamily: 'PlusJakartaSans',
/// )
/// ```
///
/// ## Using Components
///
/// Access spacing, colors, and text styles through the theme:
/// ```dart
/// // Spacing
/// Padding(padding: AppSpacing.paddingMD)
///
/// // Colors
/// Container(color: Theme.of(context).colorScheme.primary)
///
/// // Typography
/// Text('Hello', style: Theme.of(context).textTheme.headlineLarge)
///
/// // Animations
/// AnimatedContainer(
///   duration: AppAnimations.durationMedium,
///   curve: AppAnimations.curveEaseInOut,
/// )
/// ```
library;

// Theme exports
export 'src/theme/app_theme.dart';
export 'src/theme/color_tokens.dart';
export 'src/theme/typography.dart';
export 'src/theme/spacing.dart';
export 'src/theme/animations.dart';

// Buttons
export 'src/components/buttons/app_button.dart';
export 'src/components/buttons/app_icon_button.dart';

// Cards
export 'src/components/cards/app_card.dart';
export 'src/components/cards/app_glass_card.dart';

// Inputs
export 'src/components/inputs/app_text_field.dart';
export 'src/components/inputs/app_glass_text_field.dart';
export 'src/components/inputs/app_drop_down.dart';

// Loading
export 'src/components/loading/app_loading.dart';

// Feedback
export 'src/components/feedback/bottom_sheet.dart';
export 'src/components/feedback/dialog.dart';
export 'src/components/feedback/snack_bar.dart';

// States
export 'src/components/states/empty_state.dart';

// Navigation
export 'src/components/navigation/app_bar.dart';

// Calendar
export 'src/components/calendar/app_calendar.dart';

// Education
export 'src/components/education/education_widgets.dart';

// List tiles
export 'src/components/lists/list_tiles.dart';

// Adaptive
export 'src/components/adaptive/adaptive_widgets.dart';

// Data table
export 'src/components/tables/data_table.dart';

// Chat
export 'src/components/chat/chat_widgets.dart';

// File upload
export 'src/components/upload/file_upload.dart';

// Rich text editor
export 'src/components/editor/rich_text_editor.dart';

// Utilities
export 'src/utils/utilities.dart';

// Re-export
export 'package:table_calendar/table_calendar.dart';
export 'package:flutter_quill/flutter_quill.dart';
export 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
