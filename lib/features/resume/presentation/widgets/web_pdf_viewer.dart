import 'dart:html' as html;
import 'dart:ui_web' as ui_web; // <-- change here
import 'package:flutter/material.dart';

class WebPdfViewer extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;

  const WebPdfViewer({
    Key? key,
    required this.url,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<WebPdfViewer> createState() => _WebPdfViewerState();
}

class _WebPdfViewerState extends State<WebPdfViewer> {
  final String _viewId = 'pdf-viewer-${DateTime.now().millisecondsSinceEpoch}';
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePdfViewer();
  }

  void _initializePdfViewer() {
    final iframe = html.IFrameElement()
      ..src = widget.url
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%';

    // Register the iframe as a platform view
    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
      (int viewId) => iframe,
    );

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(
        viewType: _viewId,
      ),
    );
  }
}
