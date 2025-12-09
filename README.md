# edu_ui_kit

A comprehensive, flexible, and beautiful UI kit for education apps built on Flutter's Material Design 3.

## 🌟 Features

- ✅ **Material Design 3** - Latest design system with modern aesthetics
- ✅ **Flexible Theming** - Easy customization of colors and typography
- ✅ **Smooth Animations** - Polished micro-interactions throughout
- ✅ **Education-Specific** - Pre-built components for LMS platforms
- ✅ **Glassmorphism** - Premium glass effects for modern UIs
- ✅ **Dark Mode** - Full support for light and dark themes
- ✅ **Well Documented** - Inline examples for every component
- ✅ **Production Ready** - Battle-tested patterns and error handling

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  edu_ui_kit:
    git:
      url: https://github.com/mixin27/edu_ui_kit.git
```

## 🚀 Quick Start

### Basic Setup

```dart
import 'package:flutter/material.dart';
import 'package:edu_ui_kit/edu_ui_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Education App',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
```

### Custom Theme

```dart
// Customize colors
MaterialApp(
  theme: AppTheme.lightTheme(
    colors: ColorTokens(
      primary: Color(0xFF1976D2),
      secondary: Color(0xFFE91E63),
    ),
  ),
)

// Use custom font
MaterialApp(
  theme: AppTheme.lightTheme(
    fontFamily: 'PlusJakartaSans',
  ),
)

// Different colors per app (Admin, Instructor, Student)
final adminTheme = AppTheme.lightTheme(
  colors: ColorTokens(primary: Color(0xFF667eea)),
);

final instructorTheme = AppTheme.lightTheme(
  colors: ColorTokens(primary: Color(0xFF9333ea)),
);

final studentTheme = AppTheme.lightTheme(
  colors: ColorTokens(primary: Color(0xFF10b981)),
);
```

## 📚 Components Library

### Foundation
- **AppTheme** - Main theme builder
- **ColorTokens** - Flexible color system
- **AppTypography** - Text styles
- **AppSpacing** - Consistent spacing
- **AppAnimations** - Duration and curves

### Buttons
```dart
// Filled button
AppButton(
  text: 'Submit',
  onPressed: () {},
)

// Outlined button with icon
AppButton.outlined(
  text: 'Cancel',
  icon: Icons.close,
  onPressed: () {},
)

// Loading state
AppButton(
  text: 'Save',
  isLoading: true,
  onPressed: () {},
)

// Icon button
AppIconButton(
  icon: Icons.favorite,
  onPressed: () {},
)
```

### Cards
```dart
// Elevated card
AppCard.elevated(
  onTap: () {},
  child: Text('Content'),
)

// Glass card
AppGlassCard(
  child: Column(
    children: [
      Text('Premium Look'),
      Text('With blur effect'),
    ],
  ),
)
```

### Input Fields
```dart
// Text field
AppTextField(
  label: 'Email',
  prefixIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
)

// Password field (auto visibility toggle)
AppTextField(
  label: 'Password',
  obscureText: true,
)

// Dropdown
AppDropdown<String>(
  label: 'Grade',
  items: ['Grade 1', 'Grade 2', 'Grade 3'],
  onChanged: (value) {},
)

// Glass text field
AppGlassTextField(
  label: 'Username',
  hint: 'Enter username',
)
```

### Loading States
```dart
// Circular indicator
AppLoadingIndicator()
AppLoadingIndicator.large(text: 'Loading...')

// Progress bar
AppProgressBar(value: 0.7)

// Shimmer skeleton
AppShimmer(
  child: Container(
    width: 200,
    height: 20,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
    ),
  ),
)

// Pre-built skeletons
AppListItemSkeleton()
AppCardSkeleton()

// Loading overlay
AppLoadingOverlay(
  isLoading: true,
  child: YourContent(),
)
```

### Feedback
```dart
// Snackbars
AppSnackbar.success(context, message: 'Saved!');
AppSnackbar.error(context, message: 'Failed');
AppSnackbar.warning(context, message: 'Warning');

// Toasts
AppToast.info(context, message: 'Info message');
AppToast.success(context, message: 'Success', position: ToastPosition.top);

// Dialogs
await AppDialog.confirm(
  context,
  title: 'Confirm',
  message: 'Are you sure?',
);

await AppDialog.confirmDelete(
  context,
  title: 'Delete Item',
  message: 'This cannot be undone',
);

AppDialog.alert(
  context,
  title: 'Info',
  message: 'Important information',
);

// Bottom sheets
AppBottomSheet.show(
  context,
  builder: (context) => YourContent(),
);

AppBottomSheet.showOptions(
  context,
  title: 'Choose option',
  options: [
    BottomSheetOption(
      title: 'Edit',
      icon: Icons.edit,
      value: 'edit',
    ),
  ],
);
```

### Empty & Error States
```dart
// Empty state
AppEmptyState(
  icon: Icons.inbox,
  title: 'No items',
  message: 'Start by adding your first item',
  actionText: 'Add Item',
  onAction: () {},
)

// Error state
AppErrorState(
  title: 'Something went wrong',
  message: 'Please try again',
  onRetry: () {},
)

// Network error
AppNetworkErrorState(onRetry: () {})

// Coming soon
AppComingSoonState()

// Maintenance
AppMaintenanceState()

// No permission
AppNoPermissionState(onRequestPermission: () {})
```

### Education-Specific Components
```dart
// Course card
CourseCard(
  title: 'Mathematics 101',
  instructor: 'Dr. Smith',
  students: 45,
  progress: 0.7,
  onTap: () {},
)

// Grade card
GradeCard(
  subject: 'Mathematics',
  grade: 'A',
  score: 95,
  totalScore: 100,
  percentage: 95,
)

// Attendance card
AttendanceCard(
  present: 42,
  total: 50,
  onTap: () {},
)

// Assignment card
AssignmentCard(
  title: 'Math Homework',
  subject: 'Mathematics',
  dueDate: DateTime.now().add(Duration(days: 2)),
  status: AssignmentStatus.pending,
)

// Student avatar
StudentAvatar(
  name: 'John Doe',
  size: 48,
  showOnlineStatus: true,
  isOnline: true,
)
```

### Calendar
```dart
// Full calendar
AppCalendar(
  selectedDay: selectedDate,
  onDaySelected: (selected, focused) {},
  events: {
    DateTime(2024, 12, 15): ['Math Class', 'Assignment'],
    DateTime(2024, 12, 20): ['Exam'],
  },
)

// Date picker
AppDatePicker(
  label: 'Due Date',
  onDateSelected: (date) {},
)

// Date range picker
AppDateRangePicker(
  label: 'Semester Period',
  onRangeSelected: (start, end) {},
)
```

### List Components
```dart
// Enhanced list tile
AppListTile(
  title: 'Course Materials',
  subtitle: 'Access resources',
  leading: Icon(Icons.folder),
  trailing: Icon(Icons.chevron_right),
  onTap: () {},
)

// Expandable tile
AppExpandableTile(
  title: 'Week 1',
  children: [
    ListTile(title: Text('Lesson 1')),
    ListTile(title: Text('Lesson 2')),
  ],
)

// Notification tile
NotificationTile(
  title: 'New assignment',
  message: 'Math homework available',
  timestamp: DateTime.now(),
  isRead: false,
  type: NotificationType.assignment,
  onTap: () {},
)
```

## 🎨 Design Tokens

### Spacing
```dart
AppSpacing.xs    // 8px
AppSpacing.sm    // 12px
AppSpacing.md    // 16px (most common)
AppSpacing.lg    // 24px
AppSpacing.xl    // 32px
AppSpacing.xxl   // 48px

// Padding presets
AppSpacing.paddingMD
AppSpacing.paddingHorizontalLG
AppSpacing.paddingVerticalSM
AppSpacing.pagePadding
```

### Border Radius
```dart
AppRadius.sm     // 8px
AppRadius.md     // 12px
AppRadius.lg     // 16px
AppRadius.xl     // 20px

// Presets
AppRadius.buttonRadius
AppRadius.cardRadius
AppRadius.inputRadius
AppRadius.chipRadius
```

### Animation
```dart
// Durations
AppAnimations.durationFast      // 200ms
AppAnimations.durationMedium    // 300ms
AppAnimations.durationSlow      // 400ms

// Curves
AppAnimations.curveEaseInOut
AppAnimations.curveEaseOut
AppAnimations.curveSpring

// Usage
AnimatedContainer(
  duration: AppAnimations.durationMedium,
  curve: AppAnimations.curveEaseOut,
)
```

## 🎯 Best Practices

### Theme Usage
```dart
// Always use theme colors
Container(
  color: Theme.of(context).colorScheme.primary,
)

// Use semantic colors
Container(
  color: Theme.of(context).colorScheme.error, // For errors
  color: Theme.of(context).colorScheme.success, // For success
)
```

### Spacing Consistency
```dart
// Use spacing constants
Padding(
  padding: AppSpacing.paddingMD,
  child: ...,
)

// Not magic numbers
Padding(
  padding: EdgeInsets.all(16), // ❌ Don't do this
)
```

### Typography
```dart
// Use text theme
Text(
  'Title',
  style: Theme.of(context).textTheme.headlineLarge,
)

// Not hardcoded styles
Text(
  'Title',
  style: TextStyle(fontSize: 32), // ❌ Don't do this
)
```

## 📱 Example App Structure

```
Admin App:
- Primary Color: #667eea (purple-blue)
- Features: User management, analytics, system settings

Instructor App:
- Primary Color: #9333ea (purple)
- Features: Course management, grading, student tracking

Student App:
- Primary Color: #10b981 (green)
- Features: Course viewing, assignments, grades
```

## 🔧 Development

### Running Example App
```bash
cd example
flutter run
```

### Adding Google Fonts
```yaml
dependencies:
  google_fonts: ^6.1.0
```

```dart
import 'package:google_fonts/google_fonts.dart';

MaterialApp(
  theme: AppTheme.lightTheme(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
  ),
)
```

## 📄 License

MIT License - feel free to use in your projects

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📧 Support

For issues and questions, please open an issue on GitHub.

---

Built with ❤️ for education platforms
