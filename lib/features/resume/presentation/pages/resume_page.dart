import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'My Resume',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: PdfView(
              controller: PdfController(
                document: PdfDocument.openAsset('assets/cv.pdf'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}