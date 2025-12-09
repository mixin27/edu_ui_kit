import 'package:flutter/material.dart';

import '../../theme/animations.dart';

/// A dropdown field with consistent styling
///
/// Example usage:
/// ```dart
/// AppDropdown<String>(
///   label: 'Grade',
///   value: selectedGrade,
///   items: ['Grade 1', 'Grade 2', 'Grade 3'],
///   onChanged: (value) => setState(() => selectedGrade = value),
/// )
/// ```
class AppDropdown<T> extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.items,
    this.value,
    this.label,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.itemBuilder,
  });

  final List<T> items;
  final T? value;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final bool enabled;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final String Function(T)? itemBuilder;

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppAnimations.durationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.01).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.curveEaseOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getItemText(T item) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(item);
    }
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: DropdownButtonFormField<T>(
        initialValue: widget.value,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon)
              : null,
          enabled: widget.enabled,
        ),
        items: widget.items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(_getItemText(item)),
          );
        }).toList(),
        onChanged: widget.enabled ? widget.onChanged : null,
        validator: widget.validator,
        isExpanded: true,
        onTap: () {
          _animationController.forward().then((_) {
            _animationController.reverse();
          });
        },
      ),
    );
  }
}
