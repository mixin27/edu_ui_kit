import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import '../../theme/spacing.dart';
import '../education/education_widgets.dart';

/// A chat message bubble
///
/// Example usage:
/// ```dart
/// ChatBubble(
///   message: 'Hello, how can I help you?',
///   timestamp: DateTime.now(),
///   isMe: false,
///   senderName: 'Instructor',
///   senderAvatar: 'https://...',
/// )
/// ```
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.timestamp,
    this.isMe = false,
    this.senderName,
    this.senderAvatar,
    this.isRead = false,
    this.onTap,
    this.onLongPress,
  });

  final String message;
  final DateTime timestamp;
  final bool isMe;
  final String? senderName;
  final String? senderAvatar;
  final bool isRead;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe && senderAvatar != null) ...[
              StudentAvatar(
                name: senderName ?? 'User',
                imageUrl: senderAvatar,
                size: 32,
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment: isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (!isMe && senderName != null) ...[
                    Text(
                      senderName!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                  ],
                  Container(
                    padding: AppSpacing.paddingMD,
                    decoration: BoxDecoration(
                      color: isMe
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          isMe ? AppRadius.lg : AppRadius.sm,
                        ),
                        topRight: Radius.circular(
                          isMe ? AppRadius.sm : AppRadius.lg,
                        ),
                        bottomLeft: const Radius.circular(AppRadius.lg),
                        bottomRight: const Radius.circular(AppRadius.lg),
                      ),
                    ),
                    child: Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isMe
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTimestamp(timestamp),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: AppSpacing.xs),
                        Icon(
                          isRead ? Icons.done_all : Icons.done,
                          size: 14,
                          color: isRead
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (isMe && senderAvatar != null) ...[
              const SizedBox(width: AppSpacing.sm),
              StudentAvatar(
                name: senderName ?? 'You',
                imageUrl: senderAvatar,
                size: 32,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}

/// A chat input field with send button
///
/// Example usage:
/// ```dart
/// ChatInput(
///   onSend: (message) => sendMessage(message),
///   onAttachment: () => pickFile(),
/// )
/// ```
class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.onSend,
    this.onAttachment,
    this.placeholder = 'Type a message...',
    this.showAttachment = true,
  });

  final void Function(String message) onSend;
  final VoidCallback? onAttachment;
  final String placeholder;
  final bool showAttachment;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasText = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChange);
    _animationController = AnimationController(
      duration: AppAnimations.durationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.curveEaseOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
      if (hasText) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  void _handleSend() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      widget.onSend(message);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        children: [
          if (widget.showAttachment)
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: widget.onAttachment,
            ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          ScaleTransition(
            scale: _scaleAnimation,
            child: IconButton.filled(
              icon: const Icon(Icons.send),
              onPressed: _hasText ? _handleSend : null,
            ),
          ),
        ],
      ),
    );
  }
}

/// A chat list item for conversation list
///
/// Example usage:
/// ```dart
/// ChatListItem(
///   name: 'Dr. Smith',
///   avatar: 'https://...',
///   lastMessage: 'See you tomorrow!',
///   timestamp: DateTime.now(),
///   unreadCount: 3,
///   isOnline: true,
///   onTap: () => openChat(),
/// )
/// ```
class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.name,
    this.avatar,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isOnline = false,
    this.onTap,
  });

  final String name;
  final String? avatar;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isOnline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: StudentAvatar(
        name: name,
        imageUrl: avatar,
        size: 48,
        showOnlineStatus: true,
        isOnline: isOnline,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _formatTimestamp(timestamp),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              lastMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: unreadCount > 0
                    ? colorScheme.onSurface
                    : colorScheme.onSurfaceVariant,
                fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Text(
                unreadCount > 99 ? '99+' : '$unreadCount',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: onTap,
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}

/// A typing indicator for chat
class ChatTypingIndicator extends StatefulWidget {
  const ChatTypingIndicator({super.key, this.userName = 'Someone'});

  final String userName;

  @override
  State<ChatTypingIndicator> createState() => _ChatTypingIndicatorState();
}

class _ChatTypingIndicatorState extends State<ChatTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            padding: AppSpacing.paddingMD,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypingDot(animation: _controller, delay: 0.0),
                const SizedBox(width: 4),
                _TypingDot(animation: _controller, delay: 0.2),
                const SizedBox(width: 4),
                _TypingDot(animation: _controller, delay: 0.4),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '${widget.userName} is typing...',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingDot extends AnimatedWidget {
  const _TypingDot({required Animation<double> animation, required this.delay})
    : super(listenable: animation);

  final double delay;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final value = (animation.value - delay).clamp(0.0, 1.0);
    final scale = (Curves.easeInOut.transform(value) * 0.5) + 0.5;

    return Transform.scale(
      scale: scale,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
