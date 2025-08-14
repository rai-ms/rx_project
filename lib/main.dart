import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'app.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(MultiProvider(
    providers: [
      // Provider(create: (context) => ContactProvider(sendMessageUseCase: SendMessageUseCase(ContactRepositoryImpl(ContactDataSourceImpl())))),
    ],
    child: const MyApp(),
  ));
}

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

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
