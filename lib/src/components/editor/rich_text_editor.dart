import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';

import '../../theme/spacing.dart';

/// A production-ready rich text editor powered by flutter_quill
///
/// Example usage:
/// ```dart
/// final controller = AppRichTextEditorController();
///
/// AppRichTextEditor(
///   controller: controller,
///   placeholder: 'Start writing...',
///   onChanged: () => saveContent(controller.toHtml()),
/// )
///
/// // Get content
/// String html = controller.toHtml();
/// String plainText = controller.toPlainText();
/// ```
class AppRichTextEditor extends StatefulWidget {
  const AppRichTextEditor({
    super.key,
    this.controller,
    this.placeholder = 'Start typing...',
    this.minHeight = 200,
    this.maxHeight,
    this.onChanged,
    this.showToolbar = true,
    this.readOnly = false,
    this.autoFocus = false,
  });

  final AppRichTextEditorController? controller;
  final String placeholder;
  final double minHeight;
  final double? maxHeight;
  final VoidCallback? onChanged;
  final bool showToolbar;
  final bool readOnly;
  final bool autoFocus;

  @override
  State<AppRichTextEditor> createState() => _AppRichTextEditorState();
}

class _AppRichTextEditorState extends State<AppRichTextEditor> {
  late AppRichTextEditorController _controller;
  late FocusNode _focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AppRichTextEditorController();
    _controller._quillController.readOnly = widget.readOnly;

    _focusNode = FocusNode();
    _scrollController = ScrollController();

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
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
        if (widget.showToolbar)
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.md),
                topRight: Radius.circular(AppRadius.md),
              ),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: QuillSimpleToolbar(
              controller: _controller._quillController,
              config: QuillSimpleToolbarConfig(
                multiRowsDisplay: false,
                showAlignmentButtons: true,
                showBackgroundColorButton: false,
                showCenterAlignment: true,
                showCodeBlock: false,
                showColorButton: true,
                showDirection: false,
                showDividers: true,
                showFontFamily: false,
                showFontSize: false,
                showHeaderStyle: true,
                showIndent: true,
                showInlineCode: true,
                showItalicButton: true,
                showBoldButton: true,
                showUnderLineButton: true,
                showStrikeThrough: true,
                showJustifyAlignment: true,
                showLeftAlignment: true,
                showLink: true,
                showListBullets: true,
                showListCheck: true,
                showListNumbers: true,
                showQuote: true,
                showRedo: true,
                showRightAlignment: true,
                showSearchButton: false,
                showSmallButton: false,
                showSubscript: false,
                showSuperscript: false,
                showUndo: true,
              ),
            ),
          ),
        Container(
          constraints: BoxConstraints(
            minHeight: widget.minHeight,
            maxHeight: widget.maxHeight ?? double.infinity,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
            borderRadius: widget.showToolbar
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadius.md),
                    bottomRight: Radius.circular(AppRadius.md),
                  )
                : BorderRadius.circular(AppRadius.md),
          ),
          child: QuillEditor(
            controller: _controller._quillController,
            config: QuillEditorConfig(
              autoFocus: widget.autoFocus,
              placeholder: widget.placeholder,
              padding: AppSpacing.paddingMD,
              onTapDown: (details, p1) {
                widget.onChanged?.call();
                return false;
              },
            ),
            focusNode: _focusNode,
            scrollController: _scrollController,
          ),
        ),
      ],
    );
  }
}

/// Controller for AppRichTextEditor
class AppRichTextEditorController {
  AppRichTextEditorController({String? initialText}) {
    if (initialText != null && initialText.isNotEmpty) {
      _quillController = QuillController(
        document: Document()..insert(0, initialText),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _quillController = QuillController.basic();
    }
  }

  /// Create controller from HTML
  factory AppRichTextEditorController.fromHtml(String html) {
    final delta = _htmlToDelta(html);
    return AppRichTextEditorController()
      .._quillController = QuillController(
        document: Document.fromDelta(delta),
        selection: const TextSelection.collapsed(offset: 0),
      );
  }

  late QuillController _quillController;

  /// Get the quill controller for advanced usage
  QuillController get quillController => _quillController;

  /// Get plain text content
  String toPlainText() {
    return _quillController.document.toPlainText();
  }

  /// Get HTML content
  String toHtml() {
    return _deltaToHtml(_quillController.document.toDelta());
  }

  /// Get JSON content (for storage)
  String toJson() {
    return _quillController.document.toDelta().toJson().toString();
  }

  /// Load from JSON
  void fromJson(String json) {
    try {
      final delta = Delta.fromJson(json as List);
      _quillController.document = Document.fromDelta(delta);
    } catch (e) {
      debugPrint('Error loading JSON: $e');
    }
  }

  /// Clear content
  void clear() {
    _quillController.clear();
  }

  /// Check if editor is empty
  bool get isEmpty {
    return _quillController.document.isEmpty();
  }

  /// Check if editor has text
  bool get hasText {
    return !isEmpty;
  }

  /// Insert text at current position
  void insertText(String text) {
    final index = _quillController.selection.baseOffset;
    _quillController.document.insert(index, text);
  }

  /// Format selected text
  void formatText({bool? bold, bool? italic, bool? underline}) {
    if (bold != null) {
      _quillController.formatSelection(Attribute.bold);
    }
    if (italic != null) {
      _quillController.formatSelection(Attribute.italic);
    }
    if (underline != null) {
      _quillController.formatSelection(Attribute.underline);
    }
  }

  /// Add listener for content changes
  void addListener(VoidCallback listener) {
    _quillController.addListener(listener);
  }

  /// Remove listener
  void removeListener(VoidCallback listener) {
    _quillController.removeListener(listener);
  }

  void dispose() {
    _quillController.dispose();
  }

  // Helper methods for HTML conversion
  static Delta _htmlToDelta(String html) {
    // Basic HTML to Delta conversion
    // For production, consider using a proper HTML parser
    final delta = Delta();

    // Remove HTML tags for basic conversion
    String text = html
        .replaceAll(RegExp(r'<br\s*\/?>'), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '');

    delta.insert(text);
    return delta;
  }

  static String _deltaToHtml(Delta delta) {
    // Basic Delta to HTML conversion
    final buffer = StringBuffer();

    for (final op in delta.toList()) {
      if (op.data is String) {
        String text = op.data as String;

        // Apply attributes
        if (op.attributes != null) {
          if (op.attributes!['bold'] != null) {
            text = '<strong>$text</strong>';
          }
          if (op.attributes!['italic'] != null) {
            text = '<em>$text</em>';
          }
          if (op.attributes!['underline'] != null) {
            text = '<u>$text</u>';
          }
          if (op.attributes!['link'] != null) {
            text = '<a href="${op.attributes!['link']}">$text</a>';
          }
        }

        buffer.write(text.replaceAll('\n', '<br>'));
      }
    }

    return buffer.toString();
  }
}

/// A read-only rich text viewer
class AppRichTextViewer extends StatefulWidget {
  const AppRichTextViewer({super.key, required this.controller, this.padding});

  final AppRichTextEditorController controller;
  final EdgeInsets? padding;

  @override
  State<AppRichTextViewer> createState() => _AppRichTextViewerState();
}

class _AppRichTextViewerState extends State<AppRichTextViewer> {
  @override
  void initState() {
    super.initState();
    widget.controller._quillController.readOnly = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? AppSpacing.paddingMD,
      child: QuillEditor(
        controller: widget.controller._quillController,
        config: QuillEditorConfig(padding: EdgeInsets.zero),
        focusNode: FocusNode(),
        scrollController: ScrollController(),
      ),
    );
  }
}
