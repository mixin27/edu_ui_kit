import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import '../../theme/spacing.dart';

/// An enhanced list tile with more customization options
///
/// Example usage:
/// ```dart
/// AppListTile(
///   title: 'Course Materials',
///   subtitle: 'Access study resources',
///   leading: Icon(Icons.folder),
///   trailing: Icon(Icons.chevron_right),
///   onTap: () => navigate(),
/// )
/// ```
class AppListTile extends StatefulWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.selected = false,
    this.dense = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;
  final bool selected;
  final bool dense;

  @override
  State<AppListTile> createState() => _AppListTileState();
}

class _AppListTileState extends State<AppListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.durationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.curveEaseOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && widget.onTap != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;

    Widget tile = ListTile(
      title: Text(widget.title),
      subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
      leading: widget.leading,
      trailing: widget.trailing,
      onTap: widget.enabled ? widget.onTap : null,
      onLongPress: widget.enabled ? widget.onLongPress : null,
      enabled: widget.enabled,
      selected: widget.selected,
      dense: widget.dense,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    );

    if (widget.enabled && widget.onTap != null) {
      tile = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: ScaleTransition(scale: _scaleAnimation, child: tile),
      );
    }

    return tile;
  }
}

/// A list tile with expandable content
///
/// Example usage:
/// ```dart
/// AppExpandableTile(
///   title: 'Week 1: Introduction',
///   subtitle: '5 lessons',
///   children: [
///     ListTile(title: Text('Lesson 1')),
///     ListTile(title: Text('Lesson 2')),
///   ],
/// )
/// ```
class AppExpandableTile extends StatefulWidget {
  const AppExpandableTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.children,
    this.initiallyExpanded = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> children;
  final bool initiallyExpanded;

  @override
  State<AppExpandableTile> createState() => _AppExpandableTileState();
}

class _AppExpandableTileState extends State<AppExpandableTile>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: AppAnimations.durationMedium,
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.curveEaseInOut),
    );
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
          leading: widget.leading,
          trailing: RotationTransition(
            turns: _rotationAnimation,
            child: const Icon(Icons.expand_more),
          ),
          onTap: _toggleExpanded,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        AnimatedSize(
          duration: AppAnimations.durationMedium,
          curve: AppAnimations.curveEaseInOut,
          child: _isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.xl),
                  child: Column(children: widget.children),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// A swipeable list tile with actions
///
/// Example usage:
/// ```dart
/// AppSwipeableTile(
///   title: 'Assignment 1',
///   subtitle: 'Due tomorrow',
///   onEdit: () => edit(),
///   onDelete: () => delete(),
/// )
/// ```
class AppSwipeableTile extends StatelessWidget {
  const AppSwipeableTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onArchive,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onArchive;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;

    return Dismissible(
      key: Key(title),
      background: Container(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: AppSpacing.lg),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd && onEdit != null) {
          onEdit!();
          return false;
        } else if (direction == DismissDirection.endToStart &&
            onDelete != null) {
          return await _confirmDelete(context);
        }
        return false;
      },
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        leading: leading,
        onTap: onTap,
        trailing: PopupMenuButton<String>(
          itemBuilder: (context) => [
            if (onEdit != null)
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: AppSpacing.sm),
                    Text('Edit'),
                  ],
                ),
              ),
            if (onArchive != null)
              const PopupMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(Icons.archive),
                    SizedBox(width: AppSpacing.sm),
                    Text('Archive'),
                  ],
                ),
              ),
            if (onDelete != null)
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: AppSpacing.sm),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit?.call();
                break;
              case 'archive':
                onArchive?.call();
                break;
              case 'delete':
                _confirmDelete(context).then((confirmed) {
                  if (confirmed) onDelete?.call();
                });
                break;
            }
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this item?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

/// A notification list tile
///
/// Example usage:
/// ```dart
/// NotificationTile(
///   title: 'New assignment posted',
///   message: 'Math homework is now available',
///   timestamp: DateTime.now(),
///   isRead: false,
///   type: NotificationType.assignment,
///   onTap: () => viewNotification(),
/// )
/// ```
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.type = NotificationType.info,
    this.onTap,
    this.onMarkRead,
  });

  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final NotificationType type;
  final VoidCallback? onTap;
  final VoidCallback? onMarkRead;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: isRead
            ? null
            : colorScheme.primaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: _getTypeColor(type).withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(_getTypeIcon(type), color: _getTypeColor(type), size: 24),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
                ),
              ),
            ),
            if (!isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              style: theme.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              _formatTimestamp(timestamp),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        onTap: onTap,
        trailing: onMarkRead != null && !isRead
            ? IconButton(
                icon: const Icon(Icons.mark_email_read_outlined),
                onPressed: onMarkRead,
                tooltip: 'Mark as read',
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return Colors.blue;
      case NotificationType.grade:
        return Colors.green;
      case NotificationType.announcement:
        return Colors.orange;
      case NotificationType.reminder:
        return Colors.purple;
      case NotificationType.info:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return Icons.assignment_outlined;
      case NotificationType.grade:
        return Icons.grade_outlined;
      case NotificationType.announcement:
        return Icons.campaign_outlined;
      case NotificationType.reminder:
        return Icons.notifications_outlined;
      case NotificationType.info:
        return Icons.info_outlined;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

enum NotificationType { assignment, grade, announcement, reminder, info }
