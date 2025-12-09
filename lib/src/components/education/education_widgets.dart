import 'package:flutter/material.dart';

import '../../theme/spacing.dart';
import '../cards/app_card.dart';

/// A card for displaying course information
///
/// Example usage:
/// ```dart
/// CourseCard(
///   title: 'Mathematics 101',
///   instructor: 'Dr. Smith',
///   students: 45,
///   progress: 0.7,
///   imageUrl: 'https://...',
///   onTap: () => navigateToCourse(),
/// )
/// ```
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.title,
    this.subtitle,
    this.instructor,
    this.students,
    this.progress,
    this.imageUrl,
    this.imagePlaceholder = Icons.school,
    this.onTap,
    this.backgroundColor,
  });

  final String title;
  final String? subtitle;
  final String? instructor;
  final int? students;
  final double? progress;
  final String? imageUrl;
  final IconData imagePlaceholder;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppCard.elevated(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course image/placeholder
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: backgroundColor ?? colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                topRight: Radius.circular(AppRadius.lg),
              ),
            ),
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          imagePlaceholder,
                          size: 48,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      );
                    },
                  )
                : Center(
                    child: Icon(
                      imagePlaceholder,
                      size: 48,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
          ),

          Padding(
            padding: AppSpacing.paddingMD,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (instructor != null || students != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      if (instructor != null) ...[
                        Icon(
                          Icons.person_outline,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            instructor!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (students != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Icon(
                          Icons.people_outline,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '$students',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
                if (progress != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '${(progress! * 100).toInt()}%',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation(
                            colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A card for displaying student grades
///
/// Example usage:
/// ```dart
/// GradeCard(
///   subject: 'Mathematics',
///   grade: 'A',
///   score: 95,
///   totalScore: 100,
///   color: Colors.green,
/// )
/// ```
class GradeCard extends StatelessWidget {
  const GradeCard({
    super.key,
    required this.subject,
    required this.grade,
    this.score,
    this.totalScore,
    this.percentage,
    this.color,
    this.onTap,
  });

  final String subject;
  final String grade;
  final double? score;
  final double? totalScore;
  final double? percentage;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradeColor = color ?? _getGradeColor(grade, colorScheme);

    return AppCard.outlined(
      onTap: onTap,
      child: Row(
        children: [
          // Grade badge
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: gradeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Center(
              child: Text(
                grade,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: gradeColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Subject and score info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                if (score != null && totalScore != null)
                  Text(
                    '$score / $totalScore',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                if (percentage != null)
                  Text(
                    '${percentage!.toStringAsFixed(1)}%',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: gradeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),

          // Arrow icon
          if (onTap != null)
            Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade, ColorScheme colorScheme) {
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

/// A card for displaying attendance information
///
/// Example usage:
/// ```dart
/// AttendanceCard(
///   present: 42,
///   total: 50,
///   percentage: 84.0,
/// )
/// ```
class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.present,
    required this.total,
    this.percentage,
    this.title = 'Attendance',
    this.onTap,
  });

  final int present;
  final int total;
  final double? percentage;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final attendancePercentage = percentage ?? (present / total * 100);
    final statusColor = _getStatusColor(attendancePercentage, colorScheme);

    return AppCard.filled(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  '${attendancePercentage.toStringAsFixed(1)}%',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: LinearProgressIndicator(
              value: attendancePercentage / 100,
              minHeight: 8,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(statusColor),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat(
                context,
                'Present',
                present.toString(),
                Icons.check_circle_outline,
                Colors.green,
              ),
              _buildStat(
                context,
                'Absent',
                (total - present).toString(),
                Icons.cancel_outlined,
                Colors.red,
              ),
              _buildStat(
                context,
                'Total',
                total.toString(),
                Icons.calendar_today_outlined,
                colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(double percentage, ColorScheme colorScheme) {
    if (percentage >= 90) {
      return Colors.green;
    } else if (percentage >= 75) {
      return Colors.lightGreen;
    } else if (percentage >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

/// A card for displaying assignment information
///
/// Example usage:
/// ```dart
/// AssignmentCard(
///   title: 'Math Homework 5',
///   subject: 'Mathematics',
///   dueDate: DateTime(2024, 12, 15),
///   status: AssignmentStatus.pending,
///   onTap: () => viewAssignment(),
/// )
/// ```
class AssignmentCard extends StatelessWidget {
  const AssignmentCard({
    super.key,
    required this.title,
    this.subject,
    this.dueDate,
    this.submittedDate,
    this.grade,
    this.status = AssignmentStatus.pending,
    this.onTap,
  });

  final String title;
  final String? subject;
  final DateTime? dueDate;
  final DateTime? submittedDate;
  final String? grade;
  final AssignmentStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppCard.outlined(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subject != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subject!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _buildStatusBadge(context),
            ],
          ),

          if (dueDate != null || submittedDate != null || grade != null) ...[
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.md),

            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: [
                if (dueDate != null)
                  _buildInfo(
                    context,
                    Icons.calendar_today_outlined,
                    'Due: ${_formatDate(dueDate!)}',
                    _isOverdue() ? Colors.red : colorScheme.onSurfaceVariant,
                  ),
                if (submittedDate != null)
                  _buildInfo(
                    context,
                    Icons.check_circle_outline,
                    'Submitted: ${_formatDate(submittedDate!)}',
                    Colors.green,
                  ),
                if (grade != null)
                  _buildInfo(
                    context,
                    Icons.grade_outlined,
                    'Grade: $grade',
                    colorScheme.primary,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final theme = Theme.of(context);
    final config = _getStatusConfig();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: config.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 14, color: config.color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            config.label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: config.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(
    BuildContext context,
    IconData icon,
    String text,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: AppSpacing.xs),
        Text(text, style: theme.textTheme.bodySmall?.copyWith(color: color)),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  bool _isOverdue() {
    if (dueDate == null) return false;
    return status == AssignmentStatus.pending &&
        DateTime.now().isAfter(dueDate!);
  }

  _StatusConfig _getStatusConfig() {
    switch (status) {
      case AssignmentStatus.pending:
        return _StatusConfig(
          label: _isOverdue() ? 'Overdue' : 'Pending',
          icon: Icons.pending_outlined,
          color: _isOverdue() ? Colors.red : Colors.orange,
        );
      case AssignmentStatus.submitted:
        return _StatusConfig(
          label: 'Submitted',
          icon: Icons.check_circle_outline,
          color: Colors.blue,
        );
      case AssignmentStatus.graded:
        return _StatusConfig(
          label: 'Graded',
          icon: Icons.check_circle,
          color: Colors.green,
        );
    }
  }
}

enum AssignmentStatus { pending, submitted, graded }

class _StatusConfig {
  final String label;
  final IconData icon;
  final Color color;

  _StatusConfig({required this.label, required this.icon, required this.color});
}

/// A profile avatar with status indicator
///
/// Example usage:
/// ```dart
/// StudentAvatar(
///   name: 'John Doe',
///   imageUrl: 'https://...',
///   size: 48,
///   showOnlineStatus: true,
///   isOnline: true,
/// )
/// ```
class StudentAvatar extends StatelessWidget {
  const StudentAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 48,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.onTap,
  });

  final String name;
  final String? imageUrl;
  final double size;
  final bool showOnlineStatus;
  final bool isOnline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: colorScheme.primaryContainer,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
              _getInitials(name),
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
    );

    if (showOnlineStatus) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.25,
              height: size * 0.25,
              decoration: BoxDecoration(
                color: isOnline ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.surface, width: 2),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size),
        child: avatar,
      );
    }

    return avatar;
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '?';
  }
}
