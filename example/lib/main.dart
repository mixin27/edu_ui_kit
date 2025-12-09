import 'package:edu_ui_kit/edu_ui_kit.dart';
import 'package:flutter/material.dart' hide PaginatedDataTable;

import 'screens/showcasing_screen.dart';

void main() {
  runApp(const EduUIKitGalleryApp());
}

class EduUIKitGalleryApp extends StatefulWidget {
  const EduUIKitGalleryApp({super.key});

  @override
  State<EduUIKitGalleryApp> createState() => _EduUIKitGalleryAppState();
}

class _EduUIKitGalleryAppState extends State<EduUIKitGalleryApp> {
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
      debugShowCheckedModeBanner: false,
      title: 'edu_ui_kit Gallery',
      theme: AppTheme.lightTheme(colors: _colorTokens),
      darkTheme: AppTheme.darkTheme(colors: _colorTokens),
      themeMode: _themeMode,
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
    final isMediumScreen = context.isMediumScreen;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.8),
                    Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.4),
                  ],
                ),
              ),
              child: Text('Drawer'),
            ),
            AppListTile(title: 'Home', onTap: () {}),
          ],
        ),
      ),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ShowcaseHome(onToggleTheme: widget.onToggleTheme),
                ),
              );
            },
            tooltip: 'Toggle theme',
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: Row(
        children: [
          if (isMediumScreen)
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
                NavigationRailDestination(
                  icon: Icon(Icons.bug_report_outlined),
                  selectedIcon: Icon(Icons.bug_report),
                  label: Text('Test'),
                ),
              ],
            ),
          Expanded(child: _buildContent()),
        ],
      ),
      bottomNavigationBar: !isMediumScreen
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
                NavigationDestination(
                  icon: Icon(Icons.bug_report_outlined),
                  selectedIcon: Icon(Icons.bug_report),
                  label: 'Test',
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
      case 3:
        return _buildTest();
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
          childAspectRatio: 1.2,
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
    AppDialog.show(
      context,
      title: component.name,
      contentText: component.description,
      actions: [
        AppButton.text(text: 'Close', onPressed: () => Navigator.pop(context)),
        AppButton(
          text: 'View Example',
          onPressed: () {
            Navigator.pop(context);
            AppSnackbar.info(context, message: 'Example coming soon!');
          },
        ),
      ],
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

  Widget _buildTest() {
    return Padding(
      padding: AppSpacing.paddingMD,
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            AppFileUpload(onFilesSelected: (files) {}),
            const Divider(),
            AppFilePicker(label: 'Pick Image', onFilePicked: (file) {}),
            FilePreviewCard(
              file: UploadFile(
                name: 'My Document',
                size: 1024 * 1024 * 2,
                extension: 'jpeg',
              ),
            ),
            const Divider(),
            SwitchListTile(
              value: true,
              onChanged: (value) {},
              title: const Text('Switch list tile'),
              subtitle: const Text('Hello world - ON'),
            ),
            SwitchListTile(
              value: false,
              onChanged: (value) {},
              title: const Text('Switch list tile'),
              subtitle: const Text('Hello world - OFF'),
            ),

            const Divider(),

            AppBottomBar(
              items: [
                BottomAppBarItem(icon: Icons.first_page, onTap: () {}),
                BottomAppBarItem(icon: Icons.pages, onTap: () {}),
                BottomAppBarItem(icon: Icons.last_page, onTap: () {}),
                BottomAppBarItem(icon: Icons.more_vert, onTap: () {}),
              ],
            ),

            const Divider(),

            Text(800000000.withCommas),
            Text("hello world".capitalizeWords),
            Text("hello world".initials),
            Text("hello world".truncate(4)),

            const Divider(),

            SizedBox(
              height: 250,
              child: GradeTable(
                grades: [
                  GradeEntry(subject: 'Math', grade: 'A', score: 95),
                  GradeEntry(subject: 'Physics', grade: 'B+', score: 87),
                ],
              ),
            ),
          ],
        ),
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
