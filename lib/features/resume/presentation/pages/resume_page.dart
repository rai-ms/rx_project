import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rx_project/features/widget/common/app_scaffold.dart';
import 'package:rx_project/features/resume/domain/repository/resume_repository.dart';
import 'package:rx_project/features/resume/domain/models/resume_data_model.dart';
import 'package:rx_project/features/resume/presentation/widgets/web_pdf_viewer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResumePage extends StatefulWidget {
  final ResumeRepository resumeRepository;
  
  const ResumePage({
    super.key,
    required this.resumeRepository,
  });

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  bool _isLoading = true;
  String? _errorMessage;
  late ResumeDataModel _resumeData;

  @override
  void initState() {
    super.initState();
    // Initialize web view for web platform
    if (kIsWeb) {
      _loadResume();
    } else {
      _errorMessage = 'PDF viewer is only supported on web';
    }
  }

  Future<void> _loadResume() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Get the resume data from the repository
      final resumeData = await widget.resumeRepository.getResumeData();
      
      if (resumeData.resumeUrl.isEmpty) {
        throw Exception('No resume URL found in Firestore');
      }

      setState(() {
        _resumeData = resumeData;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading resume: $e');
      setState(() {
        _errorMessage = 'Failed to load resume. Please try again later.';
        _isLoading = false;
      });
    }
  }

  Widget _buildResumeContent(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[100],
          ),
          child: _resumeData.showResumeViaLink
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.picture_as_pdf, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Resume Available for Download',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () => _launchResumeUrl(),
                        icon: const Icon(Icons.download),
                        label: const Text('Download Resume'),
                      ),
                    ],
                  ),
                )
              : WebPdfViewer(
                  url: _resumeData.resumeUrl,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _launchResumeUrl,
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('Open in New Tab'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 12),
            TextButton.icon(
              onPressed: _shareResume,
              icon: const Icon(Icons.share, size: 18),
              label: const Text('Share'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _launchResumeUrl() async {
    final url = _resumeData.resumeUrl.replaceAll('/preview', '/view');
    await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _shareResume() async {
    final url = _resumeData.resumeUrl.replaceAll('/preview', '/view?usp=sharing');
    await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      sliverListBuilder: (ctx, isWide, isLoading) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'My Resume',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text(_errorMessage!))
                    : _buildResumeContent(context),
          ),
        ];
      },
    );
  }
}