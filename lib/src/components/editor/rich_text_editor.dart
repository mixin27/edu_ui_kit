import 'package:flutter/material.dart';

import '../../theme/spacing.dart';

/// A rich text editor with formatting toolbar
///
/// Example usage:
/// ```dart
/// AppRichTextEditor(
///   controller: editorController,
///   placeholder: 'Start writing...',
///   onChanged: (html) => saveContent(html),
/// )
/// ```
class AppRichTextEditor extends StatefulWidget {
  const AppRichTextEditor({
    super.key,
    this.controller,
    this.placeholder = 'Start typing...',
    this.minHeight = 200,
    this.maxHeight = 400,
    this.onChanged,
    this.showToolbar = true,
    this.readOnly = false,
  });

  final RichTextEditorController? controller;
  final String placeholder;
  final double minHeight;
  final double maxHeight;
  final void Function(String)? onChanged;
  final bool showToolbar;
  final bool readOnly;

  @override
  State<AppRichTextEditor> createState() => _AppRichTextEditorState();
}

class _AppRichTextEditorState extends State<AppRichTextEditor> {
  late RichTextEditorController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? RichTextEditorController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        if (widget.showToolbar) _buildToolbar(context),
        Container(
          constraints: BoxConstraints(
            minHeight: widget.minHeight,
            maxHeight: widget.maxHeight,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: TextField(
            controller: _controller._textController,
            focusNode: _focusNode,
            maxLines: null,
            readOnly: widget.readOnly,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              border: InputBorder.none,
              contentPadding: AppSpacing.paddingMD,
            ),
            onChanged: (text) {
              widget.onChanged?.call(_controller.getHtml());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildToolbar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.md),
          topRight: Radius.circular(AppRadius.md),
        ),
      ),
      child: Wrap(
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xs,
        children: [
          _ToolbarButton(
            icon: Icons.format_bold,
            tooltip: 'Bold',
            isActive: _controller.isBold,
            onPressed: () => _controller.toggleBold(),
          ),
          _ToolbarButton(
            icon: Icons.format_italic,
            tooltip: 'Italic',
            isActive: _controller.isItalic,
            onPressed: () => _controller.toggleItalic(),
          ),
          _ToolbarButton(
            icon: Icons.format_underlined,
            tooltip: 'Underline',
            isActive: _controller.isUnderline,
            onPressed: () => _controller.toggleUnderline(),
          ),
          const VerticalDivider(),
          _ToolbarButton(
            icon: Icons.format_list_bulleted,
            tooltip: 'Bullet List',
            onPressed: () => _controller.insertBulletList(),
          ),
          _ToolbarButton(
            icon: Icons.format_list_numbered,
            tooltip: 'Numbered List',
            onPressed: () => _controller.insertNumberedList(),
          ),
          const VerticalDivider(),
          _ToolbarButton(
            icon: Icons.link,
            tooltip: 'Insert Link',
            onPressed: () => _showLinkDialog(context),
          ),
          _ToolbarButton(
            icon: Icons.image,
            tooltip: 'Insert Image',
            onPressed: () => _showImageDialog(context),
          ),
          const VerticalDivider(),
          _ToolbarButton(
            icon: Icons.undo,
            tooltip: 'Undo',
            onPressed: () => _controller.undo(),
          ),
          _ToolbarButton(
            icon: Icons.redo,
            tooltip: 'Redo',
            onPressed: () => _controller.redo(),
          ),
        ],
      ),
    );
  }

  Future<void> _showLinkDialog(BuildContext context) async {
    final urlController = TextEditingController();
    final textController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Insert Link'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Link Text',
                hintText: 'Click here',
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'URL',
                hintText: 'https://example.com',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _controller.insertLink(urlController.text, textController.text);
              Navigator.pop(context);
            },
            child: const Text('Insert'),
          ),
        ],
      ),
    );
  }

  Future<void> _showImageDialog(BuildContext context) async {
    final urlController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Insert Image'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(
            labelText: 'Image URL',
            hintText: 'https://example.com/image.jpg',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _controller.insertImage(urlController.text);
              Navigator.pop(context);
            },
            child: const Text('Insert'),
          ),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isActive = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: isActive
            ? colorScheme.primaryContainer
            : Colors.transparent,
        foregroundColor: isActive
            ? colorScheme.onPrimaryContainer
            : colorScheme.onSurface,
      ),
    );
  }
}

/// Controller for rich text editor
class RichTextEditorController {
  RichTextEditorController({String? initialText}) {
    _textController = TextEditingController(text: initialText);
  }

  late TextEditingController _textController;
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  final List<String> _history = [];
  int _historyIndex = -1;

  void toggleBold() {
    isBold = !isBold;
    _applyFormatting();
  }

  void toggleItalic() {
    isItalic = !isItalic;
    _applyFormatting();
  }

  void toggleUnderline() {
    isUnderline = !isUnderline;
    _applyFormatting();
  }

  void insertBulletList() {
    final text = _textController.text;
    final selection = _textController.selection;
    final newText =
        '${text.substring(0, selection.start)}• ${text.substring(selection.end)}';
    _textController.text = newText;
    _saveHistory();
  }

  void insertNumberedList() {
    final text = _textController.text;
    final selection = _textController.selection;
    final newText =
        '${text.substring(0, selection.start)}1. ${text.substring(selection.end)}';
    _textController.text = newText;
    _saveHistory();
  }

  void insertLink(String url, String text) {
    final currentText = _textController.text;
    final selection = _textController.selection;
    final linkText = '[${text.isEmpty ? url : text}]($url)';
    final newText =
        '${currentText.substring(0, selection.start)}$linkText${currentText.substring(selection.end)}';
    _textController.text = newText;
    _saveHistory();
  }

  void insertImage(String url) {
    final text = _textController.text;
    final selection = _textController.selection;
    final newText =
        '${text.substring(0, selection.start)}![Image]($url)${text.substring(selection.end)}';
    _textController.text = newText;
    _saveHistory();
  }

  void undo() {
    if (_historyIndex > 0) {
      _historyIndex--;
      _textController.text = _history[_historyIndex];
    }
  }

  void redo() {
    if (_historyIndex < _history.length - 1) {
      _historyIndex++;
      _textController.text = _history[_historyIndex];
    }
  }

  String getHtml() {
    // Convert markdown-like syntax to HTML
    var html = _textController.text;

    // Bold
    html = html.replaceAllMapped(
      RegExp(r'\*\*(.*?)\*\*'),
      (match) => '<strong>${match.group(1)}</strong>',
    );

    // Italic
    html = html.replaceAllMapped(
      RegExp(r'\*(.*?)\*'),
      (match) => '<em>${match.group(1)}</em>',
    );

    // Links
    html = html.replaceAllMapped(
      RegExp(r'\[(.*?)\]\((.*?)\)'),
      (match) => '<a href="${match.group(2)}">${match.group(1)}</a>',
    );

    // Images
    html = html.replaceAllMapped(
      RegExp(r'!\[(.*?)\]\((.*?)\)'),
      (match) => '<img src="${match.group(2)}" alt="${match.group(1)}" />',
    );

    return html;
  }

  String getText() => _textController.text;

  void _applyFormatting() {
    // This is a simplified version - in production, you'd use a proper rich text library
    _saveHistory();
  }

  void _saveHistory() {
    if (_historyIndex < _history.length - 1) {
      _history.removeRange(_historyIndex + 1, _history.length);
    }
    _history.add(_textController.text);
    _historyIndex = _history.length - 1;
  }

  void dispose() {
    _textController.dispose();
  }
}

/// A read-only rich text viewer
class AppRichTextViewer extends StatelessWidget {
  const AppRichTextViewer({super.key, required this.html, this.textStyle});

  final String html;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Parse HTML and render - simplified version
    // In production, use flutter_html or similar package
    return Container(
      padding: AppSpacing.paddingMD,
      child: Text(
        _stripHtml(html),
        style: textStyle ?? theme.textTheme.bodyLarge,
      ),
    );
  }

  String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
  }
}
