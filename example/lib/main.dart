import 'package:edu_ui_kit_example/screens/showcasing_screen.dart';
import 'package:flutter/material.dart';
import 'package:edu_ui_kit/edu_ui_kit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Complete gallery app showcasing all edu_ui_kit components
///
/// Run with: flutter run -t lib/gallery/main.dart
void main() {
  runApp(const EduUIKitGallery());
}

class EduUIKitGallery extends StatefulWidget {
  const EduUIKitGallery({super.key});

  @override
  State<EduUIKitGallery> createState() => _EduUIKitGalleryState();
}

class _EduUIKitGalleryState extends State<EduUIKitGallery> {
  ThemeMode _themeMode = ThemeMode.light;
  ColorTokens _colorTokens = ColorTokens();

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  void _changeTheme(ColorTokens colors) {
    setState(() {
      _colorTokens = colors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'edu_ui_kit Gallery',
      theme: AppTheme.lightTheme(colors: _colorTokens),
      darkTheme: AppTheme.darkTheme(colors: _colorTokens),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      home: GalleryHome(
        onToggleTheme: _toggleTheme,
        onChangeTheme: _changeTheme,
        currentTheme: _themeMode,
      ),
    );
  }
}

class GalleryHome extends StatefulWidget {
  const GalleryHome({
    super.key,
    required this.onToggleTheme,
    required this.onChangeTheme,
    required this.currentTheme,
  });

  final VoidCallback onToggleTheme;
  final void Function(ColorTokens) onChangeTheme;
  final ThemeMode currentTheme;

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  final List<ComponentCategory> _categories = [
    ComponentCategory(
      name: 'Foundation',
      icon: Icons.foundation,
      components: [
        ComponentItem('Theme', 'Color & typography system'),
        ComponentItem('Spacing', 'Consistent spacing scale'),
        ComponentItem('Colors', 'Semantic color tokens'),
        ComponentItem('Typography', 'Text styles'),
        ComponentItem('Animations', 'Motion design'),
      ],
    ),
    ComponentCategory(
      name: 'Buttons',
      icon: Icons.smart_button,
      components: [
        ComponentItem('AppButton', 'Filled, outlined, text, elevated'),
        ComponentItem('AppIconButton', 'Icon-only buttons'),
        ComponentItem('Loading States', 'Button with spinner'),
        ComponentItem('Sizes', 'Small, medium, large'),
      ],
    ),
    ComponentCategory(
      name: 'Cards',
      icon: Icons.credit_card,
      components: [
        ComponentItem('AppCard', 'Elevated, outlined, filled'),
        ComponentItem('AppGlassCard', 'Glassmorphic effect'),
        ComponentItem('Interactive', 'Hover & tap animations'),
      ],
    ),
    ComponentCategory(
      name: 'Inputs',
      icon: Icons.edit,
      components: [
        ComponentItem('AppTextField', 'Text input with validation'),
        ComponentItem('AppDropdown', 'Selection dropdown'),
        ComponentItem('AppGlassTextField', 'Glass effect input'),
        ComponentItem('Validation', 'Built-in validators'),
      ],
    ),
    ComponentCategory(
      name: 'Loading',
      icon: Icons.hourglass_empty,
      components: [
        ComponentItem('AppLoadingIndicator', 'Circular spinners'),
        ComponentItem('AppProgressBar', 'Linear progress'),
        ComponentItem('AppShimmer', 'Skeleton loading'),
        ComponentItem('Skeletons', 'List & card placeholders'),
      ],
    ),
    ComponentCategory(
      name: 'Feedback',
      icon: Icons.feedback,
      components: [
        ComponentItem('Snackbars', 'Success, error, warning, info'),
        ComponentItem('Toasts', 'Top/bottom notifications'),
        ComponentItem('Dialogs', 'Alerts & confirmations'),
        ComponentItem('Bottom Sheets', 'Modal sheets'),
      ],
    ),
    ComponentCategory(
      name: 'States',
      icon: Icons.error_outline,
      components: [
        ComponentItem('Empty State', 'No data view'),
        ComponentItem('Error State', 'Error handling'),
        ComponentItem('Network Error', 'Connection issues'),
        ComponentItem('Coming Soon', 'Unavailable features'),
        ComponentItem('Maintenance', 'System down'),
        ComponentItem('No Permission', 'Access denied'),
      ],
    ),
    ComponentCategory(
      name: 'Navigation',
      icon: Icons.navigation,
      components: [
        ComponentItem('AppBar', 'Top app bars'),
        ComponentItem('Search Bar', 'Live search'),
        ComponentItem('Sliver Bar', 'Collapsible headers'),
        ComponentItem('Bottom Bar', 'Navigation bar'),
      ],
    ),
    ComponentCategory(
      name: 'Calendar',
      icon: Icons.calendar_today,
      components: [
        ComponentItem('AppCalendar', 'Full calendar with events'),
        ComponentItem('Date Picker', 'Single date selection'),
        ComponentItem('Date Range', 'Range selection'),
      ],
    ),
    ComponentCategory(
      name: 'Education',
      icon: Icons.school,
      components: [
        ComponentItem('Course Card', 'Course with progress'),
        ComponentItem('Grade Card', 'Color-coded grades'),
        ComponentItem('Attendance', 'Visual stats'),
        ComponentItem('Assignment', 'Status & due dates'),
        ComponentItem('Student Avatar', 'Profile pictures'),
      ],
    ),
    ComponentCategory(
      name: 'Lists',
      icon: Icons.list,
      components: [
        ComponentItem('AppListTile', 'Enhanced list items'),
        ComponentItem('Expandable Tile', 'Collapsible sections'),
        ComponentItem('Swipeable Tile', 'Swipe actions'),
        ComponentItem('Notification Tile', 'With timestamps'),
      ],
    ),
    ComponentCategory(
      name: 'Tables',
      icon: Icons.table_chart,
      components: [
        ComponentItem('Data Table', 'Sortable columns'),
        ComponentItem('Paginated Table', 'With pagination'),
        ComponentItem('Grade Table', 'Specialized for grades'),
      ],
    ),
    ComponentCategory(
      name: 'Adaptive',
      icon: Icons.phone_android,
      components: [
        ComponentItem('Adaptive Button', 'iOS/Android styles'),
        ComponentItem('Adaptive Dialog', 'Platform dialogs'),
        ComponentItem('Adaptive Switch', 'Platform toggles'),
        ComponentItem('Date/Time Pickers', 'Platform pickers'),
      ],
    ),
    ComponentCategory(
      name: 'Chat',
      icon: Icons.chat_bubble,
      components: [
        ComponentItem('Chat Bubble', 'Message bubbles'),
        ComponentItem('Chat Input', 'Message composer'),
        ComponentItem('Chat List', 'Conversation list'),
        ComponentItem('Typing Indicator', 'Live typing status'),
      ],
    ),
    ComponentCategory(
      name: 'File Upload',
      icon: Icons.upload_file,
      components: [
        ComponentItem('File Upload', 'Drag & drop upload'),
        ComponentItem('File Picker', 'File selection'),
        ComponentItem('File Preview', 'File cards'),
      ],
    ),
    ComponentCategory(
      name: 'Rich Text',
      icon: Icons.text_fields,
      components: [
        ComponentItem('Rich Editor', 'WYSIWYG editor'),
        ComponentItem('Toolbar', 'Formatting options'),
        ComponentItem('Rich Viewer', 'Display formatted text'),
      ],
    ),
  ];

  List<ComponentCategory> get _filteredCategories {
    if (_searchQuery.isEmpty) return _categories;

    return _categories.where((category) {
      final matchesCategory = category.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesComponent = category.components.any(
        (component) =>
            component.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            component.description.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ),
      );
      return matchesCategory || matchesComponent;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = context.isLargeScreen;

    return Scaffold(
      appBar: AppBar(
        title: const Text('edu_ui_kit Gallery'),
        actions: [
          // Theme selector
          PopupMenuButton<ColorTokens>(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Change theme',
            onSelected: widget.onChangeTheme,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ColorTokens(primary: const Color(0xFF667eea)),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF667eea),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Default (Purple-Blue)'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ColorTokens(primary: const Color(0xFF10b981)),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10b981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Student (Green)'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ColorTokens(primary: const Color(0xFF9333ea)),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9333ea),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Instructor (Purple)'),
                  ],
                ),
              ),
            ],
          ),
          AppIconButton(
            icon: widget.currentTheme == ThemeMode.light
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle theme',
          ),
          AppIconButton(
            icon: Icons.widgets_outlined,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ShowcaseHome(onToggleTheme: widget.onToggleTheme),
                ),
              );
            },
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: Row(
        children: [
          if (isLargeScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  selectedIcon: Icon(Icons.grid_view),
                  label: Text('Overview'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.code_outlined),
                  selectedIcon: Icon(Icons.code),
                  label: Text('Components'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info_outlined),
                  selectedIcon: Icon(Icons.info),
                  label: Text('About'),
                ),
              ],
            ),
          Expanded(child: _buildContent()),
        ],
      ),
      bottomNavigationBar: !isLargeScreen
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  selectedIcon: Icon(Icons.grid_view),
                  label: 'Overview',
                ),
                NavigationDestination(
                  icon: Icon(Icons.code_outlined),
                  selectedIcon: Icon(Icons.code),
                  label: 'Components',
                ),
                NavigationDestination(
                  icon: Icon(Icons.info_outlined),
                  selectedIcon: Icon(Icons.info),
                  label: 'About',
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildOverview();
      case 1:
        return _buildComponents();
      case 2:
        return _buildAbout();
      default:
        return const SizedBox();
    }
  }

  Widget _buildOverview() {
    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        Text(
          'Welcome to edu_ui_kit Gallery',
          style: context.textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'A comprehensive UI kit for education apps with 55+ components',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Stats cards
        GridView.count(
          crossAxisCount: context.isSmallScreen ? 2 : 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.3,
          children: [
            _buildStatCard('55+', 'Components', Icons.widgets_outlined),
            _buildStatCard('16', 'Categories', Icons.category_outlined),
            _buildStatCard('100%', 'Documented', Icons.description_outlined),
            _buildStatCard('M3', 'Design', Icons.palette_outlined),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        Text('Quick Links', style: context.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),

        AppCard.outlined(
          onTap: () => setState(() => _selectedIndex = 1),
          child: ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('Browse Components'),
            subtitle: const Text('Explore all available components'),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard.outlined(
          onTap: () {
            AppBottomSheet.show(
              context,
              builder: (_) => _buildQuickStartGuide(),
            );
          },
          child: const ListTile(
            leading: Icon(Icons.rocket_launch),
            title: Text('Quick Start'),
            subtitle: Text('Get started with edu_ui_kit'),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return AppCard.filled(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: context.colorScheme.primary),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponents() {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: AppSpacing.pagePadding,
          child: AppTextField(
            hint: 'Search components...',
            prefixIcon: Icons.search,
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),

        // Component list
        Expanded(
          child: ListView.builder(
            padding: AppSpacing.pagePadding,
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              final category = _filteredCategories[index];
              return _buildCategoryCard(category);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(ComponentCategory category) {
    return AppCard.outlined(
      child: AppExpandableTile(
        title: category.name,
        subtitle: '${category.components.length} components',
        leading: Icon(category.icon),
        children: category.components.map((component) {
          return AppListTile(
            title: component.name,
            subtitle: component.description,
            trailing: const Icon(Icons.code),
            onTap: () => _showComponentDetail(component),
          );
        }).toList(),
      ),
    );
  }

  void _showComponentDetail(ComponentItem component) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ComponentDetailScreen(component: component),
      ),
    );
  }

  Widget _buildAbout() {
    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        Text('About edu_ui_kit', style: context.textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),

        const Text(
          'edu_ui_kit is a comprehensive Flutter UI package designed specifically for education apps. '
          'It provides beautifully designed components with smooth animations, flexible theming, '
          'and education-specific widgets.',
        ),

        const SizedBox(height: AppSpacing.xl),

        Text('Features', style: context.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),

        _buildFeatureItem('Material Design 3', 'Latest design system'),
        _buildFeatureItem('55+ Components', 'Complete UI coverage'),
        _buildFeatureItem('Flexible Theming', 'Easy customization'),
        _buildFeatureItem('Smooth Animations', 'Polished interactions'),
        _buildFeatureItem('Adaptive Widgets', 'iOS/Android support'),
        _buildFeatureItem('Well Documented', 'Comprehensive guides'),

        const SizedBox(height: AppSpacing.xl),

        AppButton(
          text: 'View Documentation',
          icon: Icons.book_outlined,
          isFullWidth: true,
          onPressed: () {
            AppSnackbar.info(context, message: 'Opening documentation...');
          },
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: context.colorScheme.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.titleSmall),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStartGuide() {
    return Padding(
      padding: AppSpacing.bottomSheetPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Start Guide', style: context.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.lg),
          const Text('1. Add to pubspec.yaml'),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: AppSpacing.paddingSM,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Text(
              'dependencies:\n  edu_ui_kit:\n    git: ...',
              style: TextStyle(fontFamily: 'monospace'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text('2. Import and use'),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: AppSpacing.paddingSM,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Text(
              "import 'package:edu_ui_kit/edu_ui_kit.dart';",
              style: TextStyle(fontFamily: 'monospace'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            text: 'Got it!',
            isFullWidth: true,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class ComponentCategory {
  final String name;
  final IconData icon;
  final List<ComponentItem> components;

  ComponentCategory({
    required this.name,
    required this.icon,
    required this.components,
  });
}

class ComponentItem {
  final String name;
  final String description;

  ComponentItem(this.name, this.description);
}

/// Component detail screen with live examples
class ComponentDetailScreen extends StatefulWidget {
  const ComponentDetailScreen({super.key, required this.component});

  final ComponentItem component;

  @override
  State<ComponentDetailScreen> createState() => _ComponentDetailScreenState();
}

class _ComponentDetailScreenState extends State<ComponentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.component.name)),
      body: ListView(
        padding: AppSpacing.pagePadding,
        children: [
          Text(
            widget.component.description,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          Text('Live Example', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),

          // Render example based on component name
          _buildExample(widget.component.name),

          const SizedBox(height: AppSpacing.xl),

          AppCard.outlined(
            child: Padding(
              padding: AppSpacing.paddingMD,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.code, color: context.colorScheme.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Text('Usage', style: context.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: AppSpacing.paddingSM,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      _getCodeExample(widget.component.name),
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExample(String componentName) {
    // Return appropriate example based on component name
    switch (componentName.toLowerCase()) {
      case 'appbutton':
        return _ButtonExample();
      case 'appcard':
        return _CardExample();
      case 'apptextfield':
        return _TextFieldExample();
      case 'apploadingindicator':
        return _LoadingExample();
      case 'snackbars':
        return _SnackbarExample();
      case 'dialogs':
        return _DialogExample();
      case 'empty state':
        return _EmptyStateExample();
      case 'course card':
        return _CourseCardExample();
      case 'grade card':
        return _GradeCardExample();
      case 'chat bubble':
        return _ChatBubbleExample();
      case 'file upload':
        return _FileUploadExample();
      case 'rich editor':
        return _RichEditorExample();
      default:
        return AppCard.filled(
          child: Center(
            child: Text('Interactive example for ${widget.component.name}'),
          ),
        );
    }
  }

  String _getCodeExample(String componentName) {
    switch (componentName.toLowerCase()) {
      case 'appbutton':
        return '''AppButton(
  text: 'Click me',
  onPressed: () {},
)''';
      case 'appcard':
        return '''AppCard.elevated(
  child: Text('Card content'),
  onTap: () {},
)''';
      case 'apptextfield':
        return '''AppTextField(
  label: 'Email',
  prefixIcon: Icons.email,
)''';
      case 'snackbars':
        return '''AppSnackbar.success(
  context,
  message: 'Success!',
)''';
      case 'course card':
        return '''CourseCard(
  title: 'Math 101',
  instructor: 'Dr. Smith',
  progress: 0.7,
)''';
      default:
        return '// Example code for $componentName';
    }
  }
}

// Example widgets for each component type
class _ButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: 'Filled Button',
          onPressed: () {
            AppSnackbar.info(context, message: 'Button clicked!');
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton.outlined(
          text: 'Outlined Button',
          icon: Icons.add,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton.text(text: 'Text Button', onPressed: () {}),
      ],
    );
  }
}

class _CardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard.elevated(
          onTap: () {
            AppSnackbar.info(context, message: 'Card tapped!');
          },
          child: const Padding(
            padding: AppSpacing.paddingMD,
            child: Text('Tap me! I have hover animation.'),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard.outlined(
          child: const Padding(
            padding: AppSpacing.paddingMD,
            child: Text('Outlined card with border'),
          ),
        ),
      ],
    );
  }
}

class _TextFieldExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AppTextField(
          label: 'Name',
          hint: 'Enter your name',
          prefixIcon: Icons.person,
        ),
        SizedBox(height: AppSpacing.md),
        AppTextField(
          label: 'Email',
          hint: 'your@email.com',
          prefixIcon: Icons.email,
        ),
      ],
    );
  }
}

class _LoadingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AppLoadingIndicator.small(),
        SizedBox(height: AppSpacing.md),
        AppLoadingIndicator(),
        SizedBox(height: AppSpacing.md),
        AppLoadingIndicator.large(text: 'Loading...'),
      ],
    );
  }
}

class _SnackbarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: 'Show Success',
          onPressed: () {
            AppSnackbar.success(context, message: 'Operation successful!');
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          text: 'Show Error',
          onPressed: () {
            AppSnackbar.error(context, message: 'Something went wrong');
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          text: 'Show Warning',
          onPressed: () {
            AppSnackbar.warning(context, message: 'Please review your input');
          },
        ),
      ],
    );
  }
}

class _DialogExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: 'Show Alert',
          onPressed: () {
            AppDialog.alert(
              context,
              title: 'Alert',
              message: 'This is an alert dialog',
            );
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          text: 'Show Confirm',
          onPressed: () async {
            final confirmed = await AppDialog.confirm(
              context,
              title: 'Confirm',
              message: 'Are you sure?',
            );
            if (confirmed && context.mounted) {
              AppSnackbar.success(context, message: 'Confirmed!');
            }
          },
        ),
      ],
    );
  }
}

class _EmptyStateExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppEmptyState(
      icon: Icons.inbox,
      title: 'No items',
      message: 'Start by adding your first item',
    );
  }
}

class _CourseCardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CourseCard(
      title: 'Advanced Mathematics',
      subtitle: 'Calculus & Algebra',
      instructor: 'Dr. Jane Smith',
      students: 45,
      progress: 0.65,
      onTap: () {
        AppSnackbar.info(context, message: 'Opening course...');
      },
    );
  }
}

class _GradeCardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}

class _ChatBubbleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatBubble(
          message: 'Hello! How can I help you today?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isMe: false,
          senderName: 'Instructor',
        ),
        ChatBubble(
          message: 'I have a question about the homework',
          timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
          isMe: true,
          isRead: true,
        ),
      ],
    );
  }
}

class _FileUploadExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFileUpload(
      onFilesSelected: (files) {
        AppSnackbar.success(
          context,
          message: '${files.length} file(s) selected',
        );
      },
      acceptedTypes: const ['pdf', 'doc', 'docx'],
      maxFileSize: 10 * 1024 * 1024,
    );
  }
}

class _RichEditorExample extends StatefulWidget {
  @override
  State<_RichEditorExample> createState() => _RichEditorExampleState();
}

class _RichEditorExampleState extends State<_RichEditorExample> {
  final _controller = AppRichTextEditorController(
    initialText: 'Start typing here...',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppRichTextEditor(
          controller: _controller,
          placeholder: 'Write something...',
          minHeight: 150,
          onChanged: () {
            // Content changed
          },
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppButton.outlined(
                text: 'Get HTML',
                onPressed: () {
                  final html = _controller.toHtml();
                  AppSnackbar.info(
                    context,
                    message: 'HTML: ${html.substring(0, 50)}...',
                  );
                },
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton.outlined(
                text: 'Get Text',
                onPressed: () {
                  final text = _controller.toPlainText();
                  AppSnackbar.info(
                    context,
                    message: 'Text: ${text.substring(0, 50)}...',
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
