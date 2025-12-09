import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// An adaptive button that uses platform-specific design
///
/// Example usage:
/// ```dart
/// AdaptiveButton(
///   text: 'Submit',
///   onPressed: () {},
///   useAdaptive: true, // Uses Cupertino on iOS, Material on Android
/// )
/// ```
class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.useAdaptive = false,
    this.isDestructive = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool useAdaptive;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    if (useAdaptive && Platform.isIOS) {
      return CupertinoButton.filled(onPressed: onPressed, child: Text(text));
    }

    return FilledButton(
      onPressed: onPressed,
      style: isDestructive
          ? FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            )
          : null,
      child: Text(text),
    );
  }
}

/// An adaptive dialog that uses platform-specific design
///
/// Example usage:
/// ```dart
/// await AdaptiveDialog.show(
///   context,
///   title: 'Delete Item',
///   content: 'Are you sure?',
///   useAdaptive: true,
///   actions: [
///     AdaptiveDialogAction(
///       text: 'Cancel',
///       onPressed: () => Navigator.pop(context),
///     ),
///     AdaptiveDialogAction(
///       text: 'Delete',
///       isDestructive: true,
///       onPressed: () => handleDelete(),
///     ),
///   ],
/// )
/// ```
class AdaptiveDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String content,
    required List<AdaptiveDialogAction> actions,
    bool useAdaptive = false,
  }) {
    if (useAdaptive && Platform.isIOS) {
      return showCupertinoDialog<T>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions.map((action) {
            return CupertinoDialogAction(
              onPressed: action.onPressed,
              isDestructiveAction: action.isDestructive,
              child: Text(action.text),
            );
          }).toList(),
        ),
      );
    }

    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions.map((action) {
          return TextButton(
            onPressed: action.onPressed,
            style: action.isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  )
                : null,
            child: Text(action.text),
          );
        }).toList(),
      ),
    );
  }
}

class AdaptiveDialogAction {
  const AdaptiveDialogAction({
    required this.text,
    required this.onPressed,
    this.isDestructive = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isDestructive;
}

/// An adaptive switch that uses platform-specific design
///
/// Example usage:
/// ```dart
/// AdaptiveSwitch(
///   value: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
///   useAdaptive: true,
/// )
/// ```
class AdaptiveSwitch extends StatelessWidget {
  const AdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.useAdaptive = false,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool useAdaptive;

  @override
  Widget build(BuildContext context) {
    if (useAdaptive && Platform.isIOS) {
      return CupertinoSwitch(value: value, onChanged: onChanged);
    }

    return Switch(value: value, onChanged: onChanged);
  }
}

/// An adaptive activity indicator (loading spinner)
///
/// Example usage:
/// ```dart
/// AdaptiveActivityIndicator(useAdaptive: true)
/// ```
class AdaptiveActivityIndicator extends StatelessWidget {
  const AdaptiveActivityIndicator({
    super.key,
    this.useAdaptive = false,
    this.color,
  });

  final bool useAdaptive;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (useAdaptive && Platform.isIOS) {
      return CupertinoActivityIndicator(color: color);
    }

    return CircularProgressIndicator(color: color);
  }
}

/// An adaptive slider
///
/// Example usage:
/// ```dart
/// AdaptiveSlider(
///   value: volume,
///   onChanged: (value) => setState(() => volume = value),
///   useAdaptive: true,
/// )
/// ```
class AdaptiveSlider extends StatelessWidget {
  const AdaptiveSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.useAdaptive = false,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final bool useAdaptive;

  @override
  Widget build(BuildContext context) {
    if (useAdaptive && Platform.isIOS) {
      return CupertinoSlider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
      );
    }

    return Slider(value: value, onChanged: onChanged, min: min, max: max);
  }
}

/// An adaptive date picker
///
/// Example usage:
/// ```dart
/// await AdaptiveDatePicker.show(
///   context,
///   initialDate: DateTime.now(),
///   useAdaptive: true,
/// )
/// ```
class AdaptiveDatePicker {
  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool useAdaptive = false,
  }) async {
    if (useAdaptive && Platform.isIOS) {
      DateTime? selectedDate = initialDate;

      await showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: firstDate,
                    maximumDate: lastDate,
                    onDateTimeChanged: (date) {
                      selectedDate = date;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      return selectedDate;
    }

    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );
  }
}

/// An adaptive time picker
///
/// Example usage:
/// ```dart
/// await AdaptiveTimePicker.show(
///   context,
///   initialTime: TimeOfDay.now(),
///   useAdaptive: true,
/// )
/// ```
class AdaptiveTimePicker {
  static Future<TimeOfDay?> show({
    required BuildContext context,
    required TimeOfDay initialTime,
    bool useAdaptive = false,
  }) async {
    if (useAdaptive && Platform.isIOS) {
      TimeOfDay? selectedTime = initialTime;

      await showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: DateTime(
                      2000,
                      1,
                      1,
                      initialTime.hour,
                      initialTime.minute,
                    ),
                    onDateTimeChanged: (date) {
                      selectedTime = TimeOfDay(
                        hour: date.hour,
                        minute: date.minute,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      return selectedTime;
    }

    return await showTimePicker(context: context, initialTime: initialTime);
  }
}

/// Helper to check platform
class AdaptiveHelper {
  static bool get isIOS => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;

  /// Returns platform-appropriate widget
  static Widget platform<T>({required T ios, required T android}) {
    return Platform.isIOS ? ios as Widget : android as Widget;
  }
}
