import 'package:flutter/material.dart';

import '../../theme/spacing.dart';

/// A customizable data table with sorting, pagination, and actions
///
/// Example usage:
/// ```dart
/// AppDataTable<Student>(
///   columns: [
///     DataTableColumn(label: 'Name', key: 'name'),
///     DataTableColumn(label: 'Grade', key: 'grade'),
///     DataTableColumn(label: 'Attendance', key: 'attendance'),
///   ],
///   rows: students,
///   onRowTap: (student) => viewDetails(student),
///   cellBuilder: (student, key) {
///     switch (key) {
///       case 'name': return Text(student.name);
///       case 'grade': return Text(student.grade);
///       case 'attendance': return Text('${student.attendance}%');
///       default: return Text('');
///     }
///   },
/// )
/// ```
class AppDataTable<T> extends StatefulWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.cellBuilder,
    this.onRowTap,
    this.onRowLongPress,
    this.actions,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.showCheckboxColumn = false,
    this.selectedRows = const [],
    this.onSelectChanged,
  });

  final List<DataTableColumn> columns;
  final List<T> rows;
  final Widget Function(T item, String key) cellBuilder;
  final void Function(T item)? onRowTap;
  final void Function(T item)? onRowLongPress;
  final List<DataTableAction<T>>? actions;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool showCheckboxColumn;
  final List<T> selectedRows;
  final void Function(List<T>)? onSelectChanged;

  @override
  State<AppDataTable<T>> createState() => _AppDataTableState<T>();
}

class _AppDataTableState<T> extends State<AppDataTable<T>> {
  late List<T> _selectedRows;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _selectedRows = List.from(widget.selectedRows);
    _sortColumnIndex = widget.sortColumnIndex;
    _sortAscending = widget.sortAscending;
  }

  void _handleSort(int columnIndex) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumnIndex = columnIndex;
        _sortAscending = true;
      }
    });
  }

  void _handleSelectAll(bool? selected) {
    setState(() {
      if (selected == true) {
        _selectedRows = List.from(widget.rows);
      } else {
        _selectedRows.clear();
      }
    });
    widget.onSelectChanged?.call(_selectedRows);
  }

  void _handleSelectRow(T item, bool? selected) {
    setState(() {
      if (selected == true) {
        _selectedRows.add(item);
      } else {
        _selectedRows.remove(item);
      }
    });
    widget.onSelectChanged?.call(_selectedRows);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: DataTable(
          showCheckboxColumn: widget.showCheckboxColumn,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          headingRowColor: WidgetStateProperty.all(
            colorScheme.surfaceContainerHighest,
          ),
          columns: widget.columns.asMap().entries.map((entry) {
            final columnIndex = entry.key;
            final column = entry.value;
            return DataColumn(
              label: Text(
                column.label,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onSort: column.sortable
                  ? (colIndex, ascending) => _handleSort(columnIndex)
                  : null,
            );
          }).toList(),
          rows: [
            if (widget.showCheckboxColumn)
              DataRow(
                selected:
                    _selectedRows.length == widget.rows.length &&
                    widget.rows.isNotEmpty,
                onSelectChanged: _handleSelectAll,
                cells: [
                  DataCell(Text('Select All')),
                  ...List.generate(
                    widget.columns.length - 1,
                    (_) => const DataCell(Text('')),
                  ),
                ],
              ),
            ...widget.rows.map((item) {
              final isSelected = _selectedRows.contains(item);
              return DataRow(
                selected: isSelected,
                onSelectChanged: widget.showCheckboxColumn
                    ? (selected) => _handleSelectRow(item, selected)
                    : null,
                cells: [
                  ...widget.columns.map((column) {
                    return DataCell(
                      widget.cellBuilder(item, column.key),
                      onTap: widget.onRowTap != null
                          ? () => widget.onRowTap!(item)
                          : null,
                      onLongPress: widget.onRowLongPress != null
                          ? () => widget.onRowLongPress!(item)
                          : null,
                    );
                  }),
                  if (widget.actions != null && widget.actions!.isNotEmpty)
                    DataCell(
                      PopupMenuButton<DataTableAction<T>>(
                        itemBuilder: (context) => widget.actions!.map((action) {
                          return PopupMenuItem(
                            value: action,
                            child: Row(
                              children: [
                                Icon(action.icon, size: 20),
                                const SizedBox(width: AppSpacing.sm),
                                Text(action.label),
                              ],
                            ),
                          );
                        }).toList(),
                        onSelected: (action) => action.onPressed(item),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class DataTableColumn {
  const DataTableColumn({
    required this.label,
    required this.key,
    this.sortable = true,
    this.numeric = false,
  });

  final String label;
  final String key;
  final bool sortable;
  final bool numeric;
}

class DataTableAction<T> {
  const DataTableAction({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final void Function(T item) onPressed;
}

/// A paginated data table
///
/// Example usage:
/// ```dart
/// PaginatedDataTable<Student>(
///   columns: [...],
///   fetchData: (page, pageSize) async {
///     return await api.getStudents(page: page, pageSize: pageSize);
///   },
///   cellBuilder: (student, key) => ...,
///   rowsPerPage: 10,
/// )
/// ```
class PaginatedDataTable<T> extends StatefulWidget {
  const PaginatedDataTable({
    super.key,
    required this.columns,
    required this.fetchData,
    required this.cellBuilder,
    this.rowsPerPage = 10,
    this.onRowTap,
  });

  final List<DataTableColumn> columns;
  final Future<List<T>> Function(int page, int pageSize) fetchData;
  final Widget Function(T item, String key) cellBuilder;
  final int rowsPerPage;
  final void Function(T item)? onRowTap;

  @override
  State<PaginatedDataTable<T>> createState() => _PaginatedDataTableState<T>();
}

class _PaginatedDataTableState<T> extends State<PaginatedDataTable<T>> {
  int _currentPage = 0;
  List<T> _data = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final data = await widget.fetchData(_currentPage, widget.rowsPerPage);
      setState(() {
        _data = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _nextPage() {
    setState(() => _currentPage++);
    _loadData();
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        AppDataTable<T>(
          columns: widget.columns,
          rows: _data,
          cellBuilder: widget.cellBuilder,
          onRowTap: widget.onRowTap,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Page ${_currentPage + 1}', style: theme.textTheme.bodyMedium),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _currentPage > 0 ? _previousPage : null,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _data.length >= widget.rowsPerPage
                      ? _nextPage
                      : null,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// A simple grade table
///
/// Example usage:
/// ```dart
/// GradeTable(
///   grades: [
///     GradeEntry(subject: 'Math', grade: 'A', score: 95),
///     GradeEntry(subject: 'Physics', grade: 'B+', score: 87),
///   ],
/// )
/// ```
class GradeTable extends StatelessWidget {
  const GradeTable({super.key, required this.grades, this.onRowTap});

  final List<GradeEntry> grades;
  final void Function(GradeEntry)? onRowTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: AppSpacing.paddingMD,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.md),
                topRight: Radius.circular(AppRadius.md),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Subject',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Grade',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Score',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // Rows
          ...grades.asMap().entries.map((entry) {
            final index = entry.key;
            final grade = entry.value;
            final isLast = index == grades.length - 1;

            return InkWell(
              onTap: onRowTap != null ? () => onRowTap!(grade) : null,
              child: Container(
                padding: AppSpacing.paddingMD,
                decoration: BoxDecoration(
                  border: !isLast
                      ? Border(
                          bottom: BorderSide(
                            color: colorScheme.outline.withValues(alpha: 0.1),
                          ),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        grade.subject,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: _getGradeColor(
                            grade.grade,
                          ).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          grade.grade,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: _getGradeColor(grade.grade),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${grade.score}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    final upperGrade = grade.toUpperCase();
    if (upperGrade.startsWith('A')) {
      return Colors.green;
    } else if (upperGrade.startsWith('B')) {
      return Colors.lightGreen;
    } else if (upperGrade.startsWith('C')) {
      return Colors.orange;
    } else if (upperGrade.startsWith('D')) {
      return Colors.deepOrange;
    } else {
      return Colors.red;
    }
  }
}

class GradeEntry {
  const GradeEntry({
    required this.subject,
    required this.grade,
    required this.score,
  });

  final String subject;
  final String grade;
  final double score;
}
