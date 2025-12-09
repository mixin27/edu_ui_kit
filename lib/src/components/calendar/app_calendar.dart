import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../theme/animations.dart';
import '../../theme/spacing.dart';

/// A customizable calendar component for scheduling and events
///
/// Example usage:
/// ```dart
/// AppCalendar(
///   selectedDay: selectedDate,
///   onDaySelected: (date) => setState(() => selectedDate = date),
///   events: {
///     DateTime(2024, 1, 15): ['Math Class', 'Assignment Due'],
///     DateTime(2024, 1, 20): ['Exam'],
///   },
/// )
/// ```
class AppCalendar extends StatefulWidget {
  const AppCalendar({
    super.key,
    this.selectedDay,
    this.focusedDay,
    this.onDaySelected,
    this.events = const {},
    this.firstDay,
    this.lastDay,
    this.calendarFormat = CalendarFormat.month,
    this.onFormatChanged,
    this.eventMarkerBuilder,
    this.headerStyle,
  });

  final DateTime? selectedDay;
  final DateTime? focusedDay;
  final void Function(DateTime selectedDay, DateTime focusedDay)? onDaySelected;
  final Map<DateTime, List<String>> events;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final CalendarFormat calendarFormat;
  final void Function(CalendarFormat)? onFormatChanged;
  final Widget Function(BuildContext, DateTime, List<String>)?
  eventMarkerBuilder;
  final HeaderStyle? headerStyle;

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar>
    with SingleTickerProviderStateMixin {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay ?? DateTime.now();
    _selectedDay = widget.selectedDay ?? DateTime.now();
    _calendarFormat = widget.calendarFormat;

    _controller = AnimationController(
      duration: AppAnimations.durationFast,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return widget.events[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppRadius.cardRadius,
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: TableCalendar(
        firstDay: widget.firstDay ?? DateTime(2020),
        lastDay: widget.lastDay ?? DateTime(2030),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: _calendarFormat,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,

        // Styling
        calendarStyle: CalendarStyle(
          // Today
          todayDecoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),

          // Selected day
          selectedDecoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),

          // Default days
          defaultTextStyle: TextStyle(color: colorScheme.onSurface),

          // Weekend days
          weekendTextStyle: TextStyle(color: colorScheme.error),

          // Outside days
          outsideTextStyle: TextStyle(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),

          // Markers
          markersMaxCount: 3,
          markerDecoration: BoxDecoration(
            color: colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          markerSize: 6,
          markerMargin: const EdgeInsets.symmetric(horizontal: 1),
        ),

        // Header styling
        headerStyle:
            widget.headerStyle ??
            HeaderStyle(
              titleCentered: true,
              formatButtonVisible: true,
              titleTextStyle: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
              formatButtonTextStyle: theme.textTheme.labelMedium!,
              formatButtonDecoration: BoxDecoration(
                border: Border.all(color: colorScheme.outline),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: colorScheme.onSurface,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: colorScheme.onSurface,
              ),
            ),

        // Days of week styling
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
          weekendStyle: TextStyle(
            color: colorScheme.error,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Callbacks
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          widget.onDaySelected?.call(selectedDay, focusedDay);
          _controller.forward().then((_) => _controller.reverse());
        },

        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
          widget.onFormatChanged?.call(format);
        },

        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },

        // Custom event marker builder
        calendarBuilders: CalendarBuilders(
          markerBuilder: widget.eventMarkerBuilder,
        ),
      ),
    );
  }
}

/// A compact calendar picker for forms
///
/// Example usage:
/// ```dart
/// AppDatePicker(
///   selectedDate: date,
///   onDateSelected: (date) => setState(() => this.date = date),
///   label: 'Due Date',
/// )
/// ```
class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    this.selectedDate,
    this.onDateSelected,
    this.label,
    this.hint = 'Select date',
    this.firstDate,
    this.lastDate,
    this.prefixIcon = Icons.calendar_today_outlined,
  });

  final DateTime? selectedDate;
  final void Function(DateTime)? onDateSelected;
  final String? label;
  final String hint;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final IconData prefixIcon;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2020),
      lastDate: widget.lastDate ?? DateTime(2030),
      builder: (context, child) {
        return Theme(data: Theme.of(context), child: child!);
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected?.call(pickedDate);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _selectDate(context),
      borderRadius: AppRadius.inputRadius,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: _selectedDate != null
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _selectedDate = null;
                    });
                    if (_selectedDate == null) {
                      widget.onDateSelected?.call(DateTime.now());
                    }
                  },
                )
              : null,
        ),
        child: Text(
          _selectedDate != null ? _formatDate(_selectedDate!) : widget.hint,
          style: _selectedDate != null
              ? theme.textTheme.bodyLarge
              : theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
        ),
      ),
    );
  }
}

/// A date range picker
///
/// Example usage:
/// ```dart
/// AppDateRangePicker(
///   startDate: startDate,
///   endDate: endDate,
///   onRangeSelected: (start, end) {
///     setState(() {
///       startDate = start;
///       endDate = end;
///     });
///   },
/// )
/// ```
class AppDateRangePicker extends StatefulWidget {
  const AppDateRangePicker({
    super.key,
    this.startDate,
    this.endDate,
    this.onRangeSelected,
    this.label,
    this.hint = 'Select date range',
    this.firstDate,
    this.lastDate,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final void Function(DateTime start, DateTime end)? onRangeSelected;
  final String? label;
  final String hint;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<AppDateRangePicker> createState() => _AppDateRangePickerState();
}

class _AppDateRangePickerState extends State<AppDateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final pickedRange = await showDateRangePicker(
      context: context,
      firstDate: widget.firstDate ?? DateTime(2020),
      lastDate: widget.lastDate ?? DateTime(2030),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      builder: (context, child) {
        return Theme(data: Theme.of(context), child: child!);
      },
    );

    if (pickedRange != null) {
      setState(() {
        _startDate = pickedRange.start;
        _endDate = pickedRange.end;
      });
      widget.onRangeSelected?.call(pickedRange.start, pickedRange.end);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getRangeText() {
    if (_startDate != null && _endDate != null) {
      return '${_formatDate(_startDate!)} - ${_formatDate(_endDate!)}';
    }
    return widget.hint;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelection = _startDate != null && _endDate != null;

    return InkWell(
      onTap: () => _selectDateRange(context),
      borderRadius: AppRadius.inputRadius,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          prefixIcon: const Icon(Icons.date_range_outlined),
          suffixIcon: hasSelection
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _startDate = null;
                      _endDate = null;
                    });
                  },
                )
              : null,
        ),
        child: Text(
          _getRangeText(),
          style: hasSelection
              ? theme.textTheme.bodyLarge
              : theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
        ),
      ),
    );
  }
}
