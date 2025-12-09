import 'package:flutter/material.dart';

import '../buttons/app_icon_button.dart';

/// A customizable app bar with preset configurations
///
/// Example usage:
/// ```dart
/// AppBar(
///   title: AppBarTitle(text: 'Home'),
///   actions: [
///     AppIconButton(icon: Icons.search, onPressed: () {}),
///     AppIconButton(icon: Icons.more_vert, onPressed: () {}),
///   ],
/// )
/// ```
class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.text, this.subtitle});

  final String text;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (subtitle != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

/// A search app bar with text field
///
/// Example usage:
/// ```dart
/// AppSearchBar(
///   onSearch: (query) => search(query),
///   onClear: () => clearSearch(),
/// )
/// ```
class AppSearchBar extends StatefulWidget implements PreferredSizeWidget {
  const AppSearchBar({
    super.key,
    required this.onSearch,
    this.onClear,
    this.hintText = 'Search...',
    this.leading,
    this.actions,
  });

  final void Function(String) onSearch;
  final VoidCallback? onClear;
  final String hintText;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
    widget.onSearch(_controller.text);
  }

  void _handleClear() {
    _controller.clear();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      leading: widget.leading,
      title: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        style: theme.textTheme.bodyLarge,
        onSubmitted: widget.onSearch,
      ),
      actions: [
        if (_hasText) AppIconButton(icon: Icons.clear, onPressed: _handleClear),
        if (widget.actions != null) ...widget.actions!,
      ],
    );
  }
}

/// A sliver app bar with flexible space
///
/// Example usage:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     AppSliverBar(
///       title: 'Profile',
///       flexibleSpace: Image.network('...'),
///       expandedHeight: 200,
///     ),
///     SliverList(...),
///   ],
/// )
/// ```
class AppSliverBar extends StatelessWidget {
  const AppSliverBar({
    super.key,
    required this.title,
    this.flexibleSpace,
    this.expandedHeight = 200,
    this.floating = false,
    this.pinned = true,
    this.snap = false,
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? flexibleSpace;
  final double expandedHeight;
  final bool floating;
  final bool pinned;
  final bool snap;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      snap: snap,
      leading: leading,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        background: flexibleSpace,
        centerTitle: false,
      ),
    );
  }
}

/// Bottom app bar with centered FAB cutout
///
/// Example usage:
/// ```dart
/// Scaffold(
///   body: ...,
///   bottomNavigationBar: AppBottomBar(
///     items: [
///       BottomAppBarItem(icon: Icons.home, onTap: () {}),
///       BottomAppBarItem(icon: Icons.favorite, onTap: () {}),
///       null, // FAB space
///       BottomAppBarItem(icon: Icons.notifications, onTap: () {}),
///       BottomAppBarItem(icon: Icons.person, onTap: () {}),
///     ],
///   ),
///   floatingActionButton: FloatingActionButton(...),
///   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
/// )
/// ```
class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key, required this.items, this.height = 60});

  final List<BottomAppBarItem?> items;
  final double height;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;

    return BottomAppBar(
      height: height,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          if (item == null) {
            return const SizedBox(width: 48); // Space for FAB
          }
          return AppIconButton(
            icon: item.icon,
            onPressed: item.onTap,
            tooltip: item.tooltip,
          );
        }).toList(),
      ),
    );
  }
}

class BottomAppBarItem {
  const BottomAppBarItem({
    required this.icon,
    required this.onTap,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
}
