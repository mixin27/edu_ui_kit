import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../theme/animations.dart';
import '../../theme/spacing.dart';

/// A file upload widget with drag-and-drop support
///
/// Example usage:
/// ```dart
/// AppFileUpload(
///   onFilesSelected: (files) => uploadFiles(files),
///   acceptedTypes: ['pdf', 'doc', 'docx'],
///   maxFileSize: 10 * 1024 * 1024, // 10MB
/// )
/// ```
class AppFileUpload extends StatefulWidget {
  const AppFileUpload({
    super.key,
    required this.onFilesSelected,
    this.acceptedTypes,
    this.maxFileSize,
    this.maxFiles = 5,
    this.allowMultiple = true,
  });

  final void Function(List<UploadFile>) onFilesSelected;
  final List<String>? acceptedTypes;
  final int? maxFileSize;
  final int maxFiles;
  final bool allowMultiple;

  @override
  State<AppFileUpload> createState() => _AppFileUploadState();
}

class _AppFileUploadState extends State<AppFileUpload> {
  // ignore: prefer_final_fields
  bool _isDragging = false;
  final List<UploadFile> _files = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // Drop zone
        GestureDetector(
          onTap: _pickFiles,
          child: AnimatedContainer(
            duration: AppAnimations.durationMedium,
            curve: AppAnimations.curveEaseOut,
            height: 200,
            decoration: BoxDecoration(
              color: _isDragging
                  ? colorScheme.primaryContainer.withValues(alpha: 0.3)
                  : colorScheme.surfaceContainerHighest,
              border: Border.all(
                color: _isDragging
                    ? colorScheme.primary
                    : colorScheme.outline.withValues(alpha: 0.3),
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 64,
                    color: _isDragging
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Drop files here or click to browse',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  if (widget.acceptedTypes != null)
                    Text(
                      'Accepted: ${widget.acceptedTypes!.join(", ")}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  if (widget.maxFileSize != null)
                    Text(
                      'Max size: ${_formatFileSize(widget.maxFileSize!)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // File list
        if (_files.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          ..._files.map((file) => _buildFileItem(file)),
        ],
      ],
    );
  }

  Widget _buildFileItem(UploadFile file) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: AppSpacing.paddingMD,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          _buildFileIcon(file.extension),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: theme.textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Text(
                      _formatFileSize(file.size),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    if (file.uploadProgress != null) ...[
                      Text(
                        '${(file.uploadProgress! * 100).toInt()}%',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
                if (file.uploadProgress != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                    child: LinearProgressIndicator(
                      value: file.uploadProgress,
                      minHeight: 4,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _removeFile(file),
          ),
        ],
      ),
    );
  }

  Widget _buildFileIcon(String extension) {
    final colorScheme = Theme.of(context).colorScheme;
    IconData icon;
    Color color;

    switch (extension.toLowerCase()) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        color = Colors.red;
        break;
      case 'doc':
      case 'docx':
        icon = Icons.description;
        color = Colors.blue;
        break;
      case 'xls':
      case 'xlsx':
        icon = Icons.table_chart;
        color = Colors.green;
        break;
      case 'ppt':
      case 'pptx':
        icon = Icons.slideshow;
        color = Colors.orange;
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        icon = Icons.image;
        color = Colors.purple;
        break;
      case 'zip':
      case 'rar':
        icon = Icons.folder_zip;
        color = Colors.amber;
        break;
      default:
        icon = Icons.insert_drive_file;
        color = colorScheme.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(icon, color: color, size: 32),
    );
  }

  void _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      List<UploadFile> uploadFiles = List.empty(growable: true);

      for (var file in result.files) {
        String? fileName = file.name;
        int? fileSize = file.size;
        String? fileExtension = file.extension;

        final uploadFile = UploadFile(
          name: fileName,
          size: fileSize,
          extension: fileExtension ?? 'Unknown',
        );
        uploadFiles.add(uploadFile);
      }

      setState(() {
        _files.addAll(uploadFiles);
      });

      widget.onFilesSelected(uploadFiles);
    } else {
      // User canceled the picker
      debugPrint('File picking canceled.');
    }
  }

  void _removeFile(UploadFile file) {
    setState(() {
      _files.remove(file);
    });
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

class UploadFile {
  UploadFile({
    required this.name,
    required this.size,
    required this.extension,
    this.uploadProgress,
  });

  final String name;
  final int size;
  final String extension;
  double? uploadProgress;
}

/// A compact file picker button
///
/// Example usage:
/// ```dart
/// AppFilePicker(
///   label: 'Attach Assignment',
///   icon: Icons.attach_file,
///   onFilePicked: (file) => handleFile(file),
/// )
/// ```
class AppFilePicker extends StatelessWidget {
  const AppFilePicker({
    super.key,
    required this.label,
    required this.onFilePicked,
    this.icon = Icons.attach_file,
    this.acceptedTypes,
  });

  final String label;
  final IconData icon;
  final void Function(UploadFile) onFilePicked;
  final List<String>? acceptedTypes;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _pickFile(context),
      icon: Icon(icon),
      label: Text(label),
    );
  }

  void _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null) {
      String? fileName = result.files[0].name;
      int? fileSize = result.files[0].size;
      String? fileExtension = result.files[0].extension;

      final uploadFile = UploadFile(
        name: fileName,
        size: fileSize,
        extension: fileExtension ?? 'Unknown',
      );

      onFilePicked(uploadFile);
    } else {
      // User canceled the picker
      debugPrint('File picking canceled.');
    }
  }
}

/// A file preview card
class FilePreviewCard extends StatelessWidget {
  const FilePreviewCard({
    super.key,
    required this.file,
    this.onDownload,
    this.onDelete,
  });

  final UploadFile file;
  final VoidCallback? onDownload;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: AppSpacing.paddingMD,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          _buildThumbnail(context),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: theme.textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _formatFileSize(file.size),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (onDownload != null)
            IconButton(icon: const Icon(Icons.download), onPressed: onDownload),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(_getFileIcon(), color: colorScheme.onPrimaryContainer),
    );
  }

  IconData _getFileIcon() {
    switch (file.extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
