import 'package:flutter/material.dart';

import '../../theme/spacing.dart';

/// Shows a customizable bottom sheet
///
/// Example usage:
/// ```dart
/// AppBottomSheet.show(
///   context,
///   builder: (context) => Column(
///     children: [
///       ListTile(title: Text('Option 1')),
///       ListTile(title: Text('Option 2')),
///     ],
///   ),
/// )
/// ```
class AppBottomSheet {
  /// Shows a standard bottom sheet
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
    Color? backgroundColor,
    double? elevation,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.bottomSheetRadius,
      ),
      builder: (context) => _BottomSheetWrapper(child: builder(context)),
    );
  }

  /// Shows a scrollable bottom sheet with a title
  static Future<T?> showScrollable<T>(
    BuildContext context, {
    required String title,
    required WidgetBuilder builder,
    List<Widget>? actions,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.bottomSheetRadius,
      ),
      builder: (context) => _ScrollableBottomSheet(
        title: title,
        actions: actions,
        builder: builder,
      ),
    );
  }

  /// Shows a list of options
  static Future<T?> showOptions<T>(
    BuildContext context, {
    required String title,
    required List<BottomSheetOption<T>> options,
    bool isDismissible = true,
  }) {
    return show<T>(
      context,
      isDismissible: isDismissible,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1),
          ...options.map((option) {
            return ListTile(
              leading: option.icon != null ? Icon(option.icon) : null,
              title: Text(option.title),
              subtitle: option.subtitle != null ? Text(option.subtitle!) : null,
              onTap: () {
                Navigator.of(context).pop(option.value);
                option.onTap?.call();
              },
            );
          }),
        ],
      ),
    );
  }
}

class _BottomSheetWrapper extends StatelessWidget {
  const _BottomSheetWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Flexible(child: child),
      ],
    );
  }
}

class _ScrollableBottomSheet extends StatelessWidget {
  const _ScrollableBottomSheet({
    required this.title,
    required this.builder,
    this.actions,
  });

  final String title;
  final WidgetBuilder builder;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.4,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.only(
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  bottom: AppSpacing.lg + mediaQuery.padding.bottom,
                ),
                child: builder(context),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Model for bottom sheet options
class BottomSheetOption<T> {
  const BottomSheetOption({
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final T value;
  final VoidCallback? onTap;
}

/// A form bottom sheet with validation
///
/// Example usage:
/// ```dart
/// AppFormBottomSheet.show(
///   context,
///   title: 'Add Student',
///   fields: [
///     AppTextField(label: 'Name', controller: nameController),
///     AppTextField(label: 'Email', controller: emailController),
///   ],
///   onSubmit: () {
///     // Handle submit
///     return true; // Return true to close, false to keep open
///   },
/// )
/// ```
class AppFormBottomSheet {
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<Widget> fields,
    required Future<bool> Function() onSubmit,
    String submitText = 'Submit',
    String cancelText = 'Cancel',
  }) {
    return AppBottomSheet.showScrollable<T>(
      context,
      title: title,
      builder: (context) => _FormBottomSheetContent(
        fields: fields,
        onSubmit: onSubmit,
        submitText: submitText,
        cancelText: cancelText,
      ),
    );
  }
}

class _FormBottomSheetContent extends StatefulWidget {
  const _FormBottomSheetContent({
    required this.fields,
    required this.onSubmit,
    required this.submitText,
    required this.cancelText,
  });

  final List<Widget> fields;
  final Future<bool> Function() onSubmit;
  final String submitText;
  final String cancelText;

  @override
  State<_FormBottomSheetContent> createState() =>
      _FormBottomSheetContentState();
}

class _FormBottomSheetContentState extends State<_FormBottomSheetContent> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);
      try {
        final shouldClose = await widget.onSubmit();
        if (shouldClose && mounted) {
          Navigator.of(context).pop();
        }
      } finally {
        if (mounted) {
          setState(() => _isSubmitting = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...widget.fields.map((field) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: field,
            );
          }),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: Text(widget.cancelText),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(widget.submitText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
