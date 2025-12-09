# edu_ui_kit Usage Guide

Complete guide with real-world examples for building education apps.

## Table of Contents
- [Getting Started](#getting-started)
- [Theme Setup](#theme-setup)
- [Building Screens](#building-screens)
- [Advanced Patterns](#advanced-patterns)
- [Best Practices](#best-practices)

## Getting Started

### Installation

```yaml
# pubspec.yaml
dependencies:
  edu_ui_kit:
    git:
      url: https://github.com/yourusername/edu_ui_kit.git
  table_calendar: ^3.1.2
```

### Basic App Setup

```dart
import 'package:flutter/material.dart';
import 'package:edu_ui_kit/edu_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Portal',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
```

## Theme Setup

### Different Themes Per App

```dart
// admin_app/lib/main.dart
class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Portal',
      theme: AppTheme.lightTheme(
        colors: ColorTokens(
          primary: Color(0xFF667eea), // Purple-blue
          secondary: Color(0xFF764ba2),
        ),
      ),
      home: AdminDashboard(),
    );
  }
}

// instructor_app/lib/main.dart
class InstructorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instructor Portal',
      theme: AppTheme.lightTheme(
        colors: ColorTokens(
          primary: Color(0xFF9333ea), // Purple
          secondary: Color(0xFF7c3aed),
        ),
      ),
      home: InstructorDashboard(),
    );
  }
}

// student_app/lib/main.dart
class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Portal',
      theme: AppTheme.lightTheme(
        colors: ColorTokens(
          primary: Color(0xFF10b981), // Green
          secondary: Color(0xFF059669),
        ),
        fontFamily: 'PlusJakartaSans',
      ),
      home: StudentDashboard(),
    );
  }
}
```

## Building Screens

### 1. Student Dashboard

```dart
class StudentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          text: 'My Dashboard',
          subtitle: 'Welcome back, John!',
        ),
        actions: [
          AppIconButton(
            icon: Icons.notifications_outlined,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NotificationsScreen()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Attendance Overview
            AttendanceCard(
              present: 42,
              total: 50,
              onTap: () => viewAttendanceDetails(),
            ),

            SizedBox(height: AppSpacing.xl),

            // Upcoming Assignments
            Text(
              'Upcoming Assignments',
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(height: AppSpacing.md),

            AssignmentCard(
              title: 'Math Homework Chapter 5',
              subject: 'Mathematics',
              dueDate: DateTime.now().add(Duration(days: 2)),
              status: AssignmentStatus.pending,
              onTap: () => viewAssignment(),
            ),

            SizedBox(height: AppSpacing.sm),

            AssignmentCard(
              title: 'Physics Lab Report',
              subject: 'Physics',
              dueDate: DateTime.now().add(Duration(days: 5)),
              status: AssignmentStatus.pending,
              onTap: () => viewAssignment(),
            ),

            SizedBox(height: AppSpacing.xl),

            // Current Courses
            Text(
              'My Courses',
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(height: AppSpacing.md),

            GridView.count(
              crossAxisCount: context.isSmallScreen ? 1 : 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.2,
              children: [
                CourseCard(
                  title: 'Advanced Mathematics',
                  instructor: 'Dr. Jane Smith',
                  progress: 0.65,
                  onTap: () => openCourse(),
                ),
                CourseCard(
                  title: 'Physics 101',
                  instructor: 'Prof. John Doe',
                  progress: 0.45,
                  onTap: () => openCourse(),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.grade_outlined),
            selectedIcon: Icon(Icons.grade),
            label: 'Grades',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

### 2. Course Detail Screen

```dart
class CourseDetailScreen extends StatefulWidget {
  final Course course;

  const CourseDetailScreen({required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: widget.course.title,
            expandedHeight: 200,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.colorScheme.primary,
                    context.colorScheme.secondary,
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.school,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Overview'),
                    Tab(text: 'Materials'),
                    Tab(text: 'Assignments'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOverviewTab(),
                      _buildMaterialsTab(),
                      _buildAssignmentsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        AppCard.outlined(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course Information',
                style: context.textTheme.titleLarge,
              ),
              SizedBox(height: AppSpacing.md),
              _buildInfoRow('Instructor', widget.course.instructor),
              _buildInfoRow('Students', '${widget.course.students}'),
              _buildInfoRow('Duration', '12 weeks'),
              SizedBox(height: AppSpacing.md),
              Text(
                'Progress',
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: AppSpacing.sm),
              AppProgressBar(value: widget.course.progress),
              SizedBox(height: AppSpacing.xs),
              Text(
                '${(widget.course.progress * 100).toInt()}% Complete',
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.textTheme.bodyMedium),
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialsTab() {
    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        AppExpandableTile(
          title: 'Week 1: Introduction',
          subtitle: '5 lessons',
          leading: Icon(Icons.play_circle_outline),
          children: [
            AppListTile(
              title: 'Lesson 1: Course Overview',
              leading: Icon(Icons.play_arrow),
              trailing: Icon(Icons.download_outlined),
              onTap: () {},
            ),
            AppListTile(
              title: 'Lesson 2: Fundamentals',
              leading: Icon(Icons.play_arrow),
              trailing: Icon(Icons.download_outlined),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAssignmentsTab() {
    return ListView(
      padding: AppSpacing.pagePadding,
      children: [
        AssignmentCard(
          title: 'Homework 1',
          dueDate: DateTime.now().add(Duration(days: 3)),
          status: AssignmentStatus.pending,
          onTap: () {},
        ),
        SizedBox(height: AppSpacing.sm),
        AssignmentCard(
          title: 'Quiz 1',
          submittedDate: DateTime.now().subtract(Duration(days: 2)),
          grade: 'A',
          status: AssignmentStatus.graded,
          onTap: () {},
        ),
      ],
    );
  }
}
```

### 3. Grade Screen

```dart
class GradeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final grades = [
      GradeEntry(subject: 'Mathematics', grade: 'A', score: 95),
      GradeEntry(subject: 'Physics', grade: 'B+', score: 87),
      GradeEntry(subject: 'Chemistry', grade: 'A-', score: 92),
      GradeEntry(subject: 'Biology', grade: 'B', score: 85),
      GradeEntry(subject: 'English', grade: 'A', score: 94),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Grades'),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall GPA Card
            AppCard.filled(
              child: Column(
                children: [
                  Text(
                    'Overall GPA',
                    style: context.textTheme.titleMedium,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    '3.8',
                    style: context.textTheme.displayMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'out of 4.0',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl),

            // Grade Table
            Text(
              'Course Grades',
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(height: AppSpacing.md),

            GradeTable(
              grades: grades,
              onRowTap: (grade) {
                AppBottomSheet.show(
                  context,
                  builder: (_) => _buildGradeDetails(context, grade),
                );
              },
            ),

            SizedBox(height: AppSpacing.xl),

            // Individual Grade Cards
            Text(
              'Detailed Breakdown',
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(height: AppSpacing.md),

            ...grades.map((grade) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: GradeCard(
                subject: grade.subject,
                grade: grade.grade,
                score: grade.score,
                totalScore: 100,
                percentage: grade.score,
                onTap: () => viewGradeDetails(grade),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeDetails(BuildContext context, GradeEntry grade) {
    return Padding(
      padding: AppSpacing.bottomSheetPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            grade.subject,
            style: context.textTheme.headlineSmall,
          ),
          SizedBox(height: AppSpacing.lg),
          _buildDetailRow(context, 'Grade', grade.grade),
          _buildDetailRow(context, 'Score', '${grade.score}/100'),
          _buildDetailRow(context, 'Percentage', '${grade.score}%'),
          _buildDetailRow(context, 'Letter Grade', grade.grade),
          SizedBox(height: AppSpacing.lg),
          AppButton(
            text: 'View Details',
            isFullWidth: true,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.textTheme.bodyLarge),
          Text(
            value,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 4. Form with Validation

```dart
class AddAssignmentScreen extends StatefulWidget {
  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  String? _selectedCourse;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      try {
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));

        if (mounted) {
          AppSnackbar.success(
            context,
            message: 'Assignment created successfully!',
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          AppSnackbar.error(
            context,
            message: 'Failed to create assignment',
          );
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
    return Scaffold(
      appBar: AppBar(
        title: Text('New Assignment'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppSpacing.pagePadding,
          children: [
            AppTextField(
              controller: _titleController,
              label: 'Title',
              hint: 'Assignment title',
              prefixIcon: Icons.assignment_outlined,
              validator: (value) => Validators.required(
                value,
                fieldName: 'Title',
              ),
            ),

            SizedBox(height: AppSpacing.md),

            AppDropdown<String>(
              label: 'Course',
              hint: 'Select course',
              value: _selectedCourse,
              items: ['Mathematics', 'Physics', 'Chemistry'],
              prefixIcon: Icons.book_outlined,
              validator: (value) => Validators.required(
                value,
                fieldName: 'Course',
              ),
              onChanged: (value) {
                setState(() => _selectedCourse = value);
              },
            ),

            SizedBox(height: AppSpacing.md),

            AppDatePicker(
              label: 'Due Date',
              selectedDate: _dueDate,
              onDateSelected: (date) {
                setState(() => _dueDate = date);
              },
            ),

            SizedBox(height: AppSpacing.md),

            AppTextField(
              controller: _descriptionController,
              label: 'Description',
              hint: 'Assignment description',
              maxLines: 5,
              validator: (value) => Validators.minLength(value, 10),
            ),

            SizedBox(height: AppSpacing.xl),

            Row(
              children: [
                Expanded(
                  child: AppButton.outlined(
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    text: 'Create',
                    isLoading: _isSubmitting,
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## Advanced Patterns

### Async Data Loading with States

```dart
class StudentListScreen extends StatefulWidget {
  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student>? _students;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final students = await api.getStudents();
      setState(() {
        _students = students;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addStudent(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => AppListItemSkeleton(),
      );
    }

    if (_error != null) {
      return AppErrorState(
        title: 'Failed to load students',
        message: _error,
        onRetry: _loadStudents,
      );
    }

    if (_students == null || _students!.isEmpty) {
      return AppEmptyState(
        icon: Icons.people_outline,
        title: 'No students yet',
        message: 'Add your first student to get started',
        actionText: 'Add Student',
        onAction: () => addStudent(),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadStudents,
      child: ListView.builder(
        padding: AppSpacing.pagePadding,
        itemCount: _students!.length,
        itemBuilder: (context, index) {
          final student = _students![index];
          return AppListTile(
            title: student.name,
            subtitle: student.email,
            leading: StudentAvatar(
              name: student.name,
              imageUrl: student.avatarUrl,
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () => viewStudent(student),
          );
        },
      ),
    );
  }
}
```

## Best Practices

### 1. Use Theme Extensions

```dart
// ✅ Good
Container(
  color: context.colorScheme.primary,
  padding: AppSpacing.paddingMD,
)

// ❌ Bad
Container(
  color: Colors.blue,
  padding: EdgeInsets.all(16),
)
```

### 2. Responsive Design

```dart
GridView.count(
  crossAxisCount: ResponsiveValue.value(
    context: context,
    mobile: 1,
    tablet: 2,
    desktop: 3,
  ),
)
```

### 3. Consistent Spacing

```dart
// ✅ Good
Column(
  children: [
    Widget1(),
    SizedBox(height: AppSpacing.md),
    Widget2(),
  ],
)

// ❌ Bad
Column(
  children: [
    Widget1(),
    SizedBox(height: 16),
    Widget2(),
  ],
)
```

### 4. Error Handling

```dart
try {
  await someAsyncOperation();
  AppSnackbar.success(context, message: 'Success!');
} catch (e) {
  AppSnackbar.error(
    context,
    message: 'Operation failed',
    action: SnackBarAction(
      label: 'Retry',
      onPressed: () => retry(),
    ),
  );
}
```

### 5. Form Validation

```dart
AppTextField(
  validator: Validators.combine([
    (value) => Validators.required(value, fieldName: 'Email'),
    Validators.email,
  ]),
)
```

---

For more examples, check the example app in the package repository.
