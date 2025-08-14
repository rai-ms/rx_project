import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  late PdfControllerPinch _pdfController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final document = PdfDocument.openAsset('assets/resume.pdf');
      if (mounted) {
        setState(() {
          _pdfController = PdfControllerPinch(document: document);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load resume')),
        );
      }
    }
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              AppBar(
                title: const Text('My Resume'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      // TODO: Implement download functionality
                    },
                  ),
                ],
              ),
              Expanded(
                child: PdfViewPinch(
                  controller: _pdfController,
                ),
              ),
            ],
          );
  }
}
