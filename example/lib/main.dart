import 'package:edu_ui_kit/edu_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const EduUIKitExampleApp());
}

class EduUIKitExampleApp extends StatefulWidget {
  const EduUIKitExampleApp({super.key});

  @override
  State<EduUIKitExampleApp> createState() => _EduUIKitExampleAppState();
}

class _EduUIKitExampleAppState extends State<EduUIKitExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduUIKit Showcase',
      theme: AppTheme.lightTheme(
        colors: ColorTokens(primary: Colors.brown, secondary: Colors.amber),
        fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      ),
      darkTheme: AppTheme.darkTheme(
        colors: ColorTokens(primary: Colors.brown, secondary: Colors.amber),
        fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      ),
      themeMode: _themeMode,
      home: ShowcaseHome(onToggleTheme: _toggleTheme),
    );
  }
}

class ShowcaseHome extends StatefulWidget {
  const ShowcaseHome({super.key, required this.onToggleTheme});

  final VoidCallback onToggleTheme;

  @override
  State<ShowcaseHome> createState() => _ShowcaseHomeState();
}

class _ShowcaseHomeState extends State<ShowcaseHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ButtonsShowcase(),
    CardsShowcase(),
    InputsShowcase(),
    LoadingShowcase(),
    FeedbackShowcase(),
    StatesShowcase(),
    EducationShowcase(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(text: 'EduUIKit Showcase'),
        actions: [
          AppIconButton(
            icon: theme.brightness == Brightness.light
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle theme',
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.smart_button_outlined),
            selectedIcon: Icon(Icons.smart_button),
            label: 'Buttons',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            selectedIcon: Icon(Icons.credit_card),
            label: 'Cards',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_outlined),
            selectedIcon: Icon(Icons.edit),
            label: 'Inputs',
          ),
          NavigationDestination(
            icon: Icon(Icons.hourglass_empty_outlined),
            selectedIcon: Icon(Icons.hourglass_empty),
            label: 'Loading',
          ),
          NavigationDestination(
            icon: Icon(Icons.feedback_outlined),
            selectedIcon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          NavigationDestination(
            icon: Icon(Icons.error_outline),
            selectedIcon: Icon(Icons.error),
            label: 'States',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Education',
          ),
        ],
      ),
    );
  }
}

// Buttons Showcase
class ButtonsShowcase extends StatefulWidget {
  const ButtonsShowcase({super.key});

  @override
  State<ButtonsShowcase> createState() => _ButtonsShowcaseState();
}

class _ButtonsShowcaseState extends State<ButtonsShowcase> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        Text('Buttons', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),

        // Filled Buttons
        _Section(
          title: 'Filled Buttons',
          children: [
            AppButton(text: 'Primary Button', onPressed: () {}),
            const SizedBox(height: AppSpacing.sm),
            AppButton(text: 'With Icon', icon: Icons.send, onPressed: () {}),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Loading',
              isLoading: _isLoading,
              onPressed: () {
                setState(() => _isLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() => _isLoading = false);
                });
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(text: 'Disabled', onPressed: null),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        // Outlined Buttons
        _Section(
          title: 'Outlined Buttons',
          children: [
            AppButton.outlined(text: 'Outlined', onPressed: () {}),
            const SizedBox(height: AppSpacing.sm),
            AppButton.outlined(
              text: 'With Icon',
              icon: Icons.download,
              onPressed: () {},
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        // Text Buttons
        _Section(
          title: 'Text Buttons',
          children: [
            AppButton.text(text: 'Text Button', onPressed: () {}),
            const SizedBox(height: AppSpacing.sm),
            AppButton.text(
              text: 'With Icon',
              icon: Icons.info_outline,
              onPressed: () {},
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        // Icon Buttons
        _Section(
          title: 'Icon Buttons',
          children: [
            Row(
              children: [
                AppIconButton(
                  icon: Icons.favorite_border,
                  onPressed: () {},
                  tooltip: 'Like',
                ),
                const SizedBox(width: AppSpacing.sm),
                AppIconButton.filled(
                  icon: Icons.share,
                  onPressed: () {},
                  tooltip: 'Share',
                ),
                const SizedBox(width: AppSpacing.sm),
                AppIconButton.outlined(
                  icon: Icons.bookmark_border,
                  onPressed: () {},
                  tooltip: 'Bookmark',
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        // Button Sizes
        _Section(
          title: 'Button Sizes',
          children: [
            AppButton(
              text: 'Small',
              size: AppButtonSize.small,
              onPressed: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Medium',
              size: AppButtonSize.medium,
              onPressed: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Large',
              size: AppButtonSize.large,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

// Cards Showcase
class CardsShowcase extends StatelessWidget {
  const CardsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        Text('Cards', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),

        _Section(
          title: 'Elevated Card',
          children: [
            AppCard.elevated(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Elevated Card', style: theme.textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'This card has a shadow effect. Hover or tap to see the animation.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Outlined Card',
          children: [
            AppCard.outlined(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Outlined Card', style: theme.textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'This card has a border instead of shadow.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Filled Card',
          children: [
            AppCard.filled(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Filled Card', style: theme.textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'This card has a filled background color.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Glass Card',
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                ),
                borderRadius: AppRadius.cardRadius,
              ),
              child: Center(
                child: AppGlassCard(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Glass Card', style: theme.textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Beautiful glassmorphic effect with blur and transparency.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Inputs Showcase
class InputsShowcase extends StatefulWidget {
  const InputsShowcase({super.key});

  @override
  State<InputsShowcase> createState() => _InputsShowcaseState();
}

class _InputsShowcaseState extends State<InputsShowcase> {
  String? _selectedGrade;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        Text('Input Fields', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),

        _Section(
          title: 'Text Fields',
          children: [
            const AppTextField(
              label: 'Name',
              hint: 'Enter your name',
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(
              label: 'Email',
              hint: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(
              label: 'Password',
              hint: 'Enter your password',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(
              label: 'Bio',
              hint: 'Tell us about yourself',
              maxLines: 4,
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Dropdown',
          children: [
            AppDropdown<String>(
              label: 'Grade',
              hint: 'Select grade',
              prefixIcon: Icons.school_outlined,
              value: _selectedGrade,
              items: const ['Grade 1', 'Grade 2', 'Grade 3', 'Grade 4'],
              onChanged: (value) => setState(() => _selectedGrade = value),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Glass Text Field',
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.tertiary,
                  ],
                ),
                borderRadius: AppRadius.cardRadius,
              ),
              padding: AppSpacing.paddingMD,
              child: const Center(
                child: AppGlassTextField(
                  label: 'Username',
                  hint: 'Enter username',
                  prefixIcon: Icons.account_circle_outlined,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Loading Showcase
class LoadingShowcase extends StatelessWidget {
  const LoadingShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        Text('Loading States', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),

        _Section(
          title: 'Loading Indicators',
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                AppLoadingIndicator.small(),
                AppLoadingIndicator(),
                AppLoadingIndicator.large(),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            const AppLoadingIndicator(text: 'Loading data...'),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Progress Bar',
          children: [
            const AppProgressBar(value: 0.3),
            const SizedBox(height: AppSpacing.md),
            const AppProgressBar(value: 0.7),
            const SizedBox(height: AppSpacing.md),
            const AppProgressBar(), // Indeterminate
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Shimmer Loading',
          children: [
            AppListItemSkeleton(),
            AppListItemSkeleton(),
            const SizedBox(height: AppSpacing.lg),
            AppCardSkeleton(height: 220),
          ],
        ),
      ],
    );
  }
}

// Feedback Showcase
class FeedbackShowcase extends StatelessWidget {
  const FeedbackShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        Text('Feedback', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),

        _Section(
          title: 'Snackbars',
          children: [
            AppButton(
              text: 'Show Snackbar',
              onPressed: () {
                AppSnackbar.show(
                  context,
                  message: 'This is a standard snackbar',
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Success',
              onPressed: () {
                AppSnackbar.success(
                  context,
                  message: 'Task completed successfully!',
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Error',
              onPressed: () {
                AppSnackbar.error(
                  context,
                  message: 'Something went wrong',
                  action: SnackBarAction(label: 'Retry', onPressed: () {}),
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Warning',
              onPressed: () {
                AppSnackbar.warning(
                  context,
                  message: 'Please review your input',
                );
              },
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Toasts',
          children: [
            AppButton(
              text: 'Show Toast (Bottom)',
              onPressed: () {
                AppToast.info(
                  context,
                  message: 'This is a toast message',
                  position: ToastPosition.bottom,
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Show Toast (Top)',
              onPressed: () {
                AppToast.success(
                  context,
                  message: 'Saved successfully',
                  position: ToastPosition.top,
                );
              },
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Dialogs',
          children: [
            AppButton(
              text: 'Show Dialog',
              onPressed: () {
                AppDialog.show(
                  context,
                  title: 'Dialog Title',
                  contentText:
                      'This is a standard dialog with customizable content.',
                  actions: [
                    AppButton.text(
                      text: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                    ),
                    AppButton(
                      text: 'OK',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Confirm Dialog',
              onPressed: () async {
                final confirmed = await AppDialog.confirm(
                  context,
                  title: 'Confirm Action',
                  message: 'Are you sure you want to proceed?',
                );
                if (confirmed && context.mounted) {
                  AppSnackbar.success(context, message: 'Confirmed!');
                }
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Delete Confirmation',
              onPressed: () async {
                await AppDialog.confirmDelete(
                  context,
                  title: 'Delete Item',
                  message: 'This action cannot be undone.',
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Alert Dialog',
              onPressed: () {
                AppDialog.alert(
                  context,
                  title: 'Information',
                  message: 'This is an informational alert.',
                );
              },
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Bottom Sheets',
          children: [
            AppButton(
              text: 'Show Bottom Sheet',
              onPressed: () {
                AppBottomSheet.show(
                  context,
                  builder: (context) => Padding(
                    padding: AppSpacing.paddingLG,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bottom Sheet', style: theme.textTheme.titleLarge),
                        const SizedBox(height: AppSpacing.md),
                        const Text(
                          'This is a bottom sheet with custom content.',
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppButton(
                          text: 'Close',
                          isFullWidth: true,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Show Options',
              onPressed: () {
                AppBottomSheet.showOptions<String>(
                  context,
                  title: 'Choose an option',
                  options: [
                    const BottomSheetOption(
                      title: 'Edit',
                      subtitle: 'Modify this item',
                      icon: Icons.edit,
                      value: 'edit',
                    ),
                    const BottomSheetOption(
                      title: 'Share',
                      subtitle: 'Share with others',
                      icon: Icons.share,
                      value: 'share',
                    ),
                    const BottomSheetOption(
                      title: 'Delete',
                      subtitle: 'Remove this item',
                      icon: Icons.delete,
                      value: 'delete',
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Scrollable Sheet',
              onPressed: () {
                AppBottomSheet.showScrollable(
                  context,
                  title: 'Scrollable Content',
                  builder: (context) => Column(
                    children: List.generate(
                      20,
                      (index) => ListTile(title: Text('Item ${index + 1}')),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

// States Showcase
class StatesShowcase extends StatefulWidget {
  const StatesShowcase({super.key});

  @override
  State<StatesShowcase> createState() => _StatesShowcaseState();
}

class _StatesShowcaseState extends State<StatesShowcase> {
  String _currentState = 'empty';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Empty & Error States',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  FilterChip(
                    label: const Text('Empty'),
                    selected: _currentState == 'empty',
                    onSelected: (selected) {
                      setState(() => _currentState = 'empty');
                    },
                  ),
                  FilterChip(
                    label: const Text('Error'),
                    selected: _currentState == 'error',
                    onSelected: (selected) {
                      setState(() => _currentState = 'error');
                    },
                  ),
                  FilterChip(
                    label: const Text('Network Error'),
                    selected: _currentState == 'network',
                    onSelected: (selected) {
                      setState(() => _currentState = 'network');
                    },
                  ),
                  FilterChip(
                    label: const Text('Coming Soon'),
                    selected: _currentState == 'coming_soon',
                    onSelected: (selected) {
                      setState(() => _currentState = 'coming_soon');
                    },
                  ),
                  FilterChip(
                    label: const Text('Maintenance'),
                    selected: _currentState == 'maintenance',
                    onSelected: (selected) {
                      setState(() => _currentState = 'maintenance');
                    },
                  ),
                  FilterChip(
                    label: const Text('No Permission'),
                    selected: _currentState == 'no_permission',
                    onSelected: (selected) {
                      setState(() => _currentState = 'no_permission');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(child: _buildCurrentState()),
      ],
    );
  }

  Widget _buildCurrentState() {
    switch (_currentState) {
      case 'empty':
        return const AppEmptyState(
          icon: Icons.inbox_outlined,
          title: 'No items yet',
          message: 'Start by adding your first item.',
          actionText: 'Add Item',
        );
      case 'error':
        return AppErrorState(
          title: 'Something went wrong',
          message: 'We couldn\'t load the data. Please try again.',
          onRetry: () {
            AppSnackbar.info(context, message: 'Retrying...');
          },
        );
      case 'network':
        return AppNetworkErrorState(
          onRetry: () {
            AppSnackbar.info(context, message: 'Checking connection...');
          },
        );
      case 'coming_soon':
        return const AppComingSoonState();
      case 'maintenance':
        return const AppMaintenanceState();
      case 'no_permission':
        return AppNoPermissionState(
          onRequestPermission: () {
            AppSnackbar.info(context, message: 'Requesting permission...');
          },
        );
      default:
        return const SizedBox();
    }
  }
}

// Education Showcase
class EducationShowcase extends StatefulWidget {
  const EducationShowcase({super.key});

  @override
  State<EducationShowcase> createState() => _EducationShowcaseState();
}

class _EducationShowcaseState extends State<EducationShowcase> {
  DateTime? _selectedDate;
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        Text('Education Widgets', style: theme.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),

        _Section(
          title: 'Course Cards',
          children: [
            CourseCard(
              title: 'Advanced Mathematics',
              subtitle: 'Calculus & Linear Algebra',
              instructor: 'Dr. Jane Smith',
              students: 45,
              progress: 0.65,
              onTap: () {
                AppSnackbar.info(context, message: 'Opening course...');
              },
            ),
            const SizedBox(height: AppSpacing.md),
            CourseCard(
              title: 'Introduction to Physics',
              subtitle: 'Classical Mechanics',
              instructor: 'Prof. John Doe',
              students: 38,
              progress: 0.25,
              backgroundColor: Colors.deepPurple.shade100,
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Grade Cards',
          children: [
            GradeCard(
              subject: 'Mathematics',
              grade: 'A',
              score: 95,
              totalScore: 100,
              percentage: 95,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            GradeCard(
              subject: 'Physics',
              grade: 'B+',
              score: 87,
              totalScore: 100,
              percentage: 87,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            GradeCard(
              subject: 'Chemistry',
              grade: 'A-',
              score: 92,
              totalScore: 100,
              percentage: 92,
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Attendance Card',
          children: [
            AttendanceCard(
              present: 42,
              total: 50,
              onTap: () {
                AppSnackbar.info(
                  context,
                  message: 'Viewing attendance details...',
                );
              },
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Assignment Cards',
          children: [
            AssignmentCard(
              title: 'Math Homework Chapter 5',
              subject: 'Mathematics',
              dueDate: DateTime.now().add(const Duration(days: 2)),
              status: AssignmentStatus.pending,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            AssignmentCard(
              title: 'Physics Lab Report',
              subject: 'Physics',
              dueDate: DateTime.now().subtract(const Duration(days: 1)),
              status: AssignmentStatus.pending,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            AssignmentCard(
              title: 'Chemistry Quiz',
              subject: 'Chemistry',
              submittedDate: DateTime.now().subtract(const Duration(days: 3)),
              grade: 'A',
              status: AssignmentStatus.graded,
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Student Avatars',
          children: [
            Row(
              children: [
                const StudentAvatar(
                  name: 'John Doe',
                  size: 56,
                  showOnlineStatus: true,
                  isOnline: true,
                ),
                const SizedBox(width: AppSpacing.md),
                const StudentAvatar(
                  name: 'Jane Smith',
                  size: 56,
                  showOnlineStatus: true,
                  isOnline: false,
                ),
                const SizedBox(width: AppSpacing.md),
                const StudentAvatar(
                  name: 'Bob Wilson',
                  size: 56,
                  showOnlineStatus: true,
                  isOnline: true,
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Calendar',
          children: [
            AppCalendar(
              selectedDay: _selectedDate,
              focusedDay: _focusedDate,
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDate = selected;
                  _focusedDate = focused;
                });
                AppSnackbar.info(
                  context,
                  message:
                      'Selected: ${selected.day}/${selected.month}/${selected.year}',
                );
              },
              events: {
                DateTime.now(): ['Math Class', 'Assignment Due'],
                DateTime.now().add(const Duration(days: 2)): ['Physics Exam'],
                DateTime.now().add(const Duration(days: 5)): ['Chemistry Lab'],
              },
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'Date Pickers',
          children: [
            AppDatePicker(
              label: 'Due Date',
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() => _selectedDate = date);
              },
            ),
            const SizedBox(height: AppSpacing.md),
            AppDateRangePicker(
              label: 'Semester Period',
              hint: 'Select start and end date',
              onRangeSelected: (start, end) {
                AppSnackbar.success(
                  context,
                  message:
                      'Range selected: ${start.day}/${start.month} - ${end.day}/${end.month}',
                );
              },
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        _Section(
          title: 'List Tiles',
          children: [
            const AppListTile(
              title: 'Course Materials',
              subtitle: 'Download study resources',
              leading: Icon(Icons.folder_outlined),
              trailing: Icon(Icons.chevron_right),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppExpandableTile(
              title: 'Week 1: Introduction',
              subtitle: '5 lessons',
              leading: const Icon(Icons.play_circle_outline),
              children: [
                const AppListTile(
                  title: 'Lesson 1: Overview',
                  leading: Icon(Icons.play_arrow),
                ),
                const AppListTile(
                  title: 'Lesson 2: Fundamentals',
                  leading: Icon(Icons.play_arrow),
                ),
                const AppListTile(
                  title: 'Lesson 3: Practice',
                  leading: Icon(Icons.play_arrow),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            NotificationTile(
              title: 'New assignment posted',
              message:
                  'Math homework for Chapter 5 is now available. Due date: Dec 15',
              timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
              isRead: false,
              type: NotificationType.assignment,
              onTap: () {},
              onMarkRead: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            NotificationTile(
              title: 'Grade published',
              message: 'Your Physics quiz has been graded. Score: 92/100',
              timestamp: DateTime.now().subtract(const Duration(hours: 2)),
              isRead: true,
              type: NotificationType.grade,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

// Helper widget for sections
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...children,
      ],
    );
  }
}
