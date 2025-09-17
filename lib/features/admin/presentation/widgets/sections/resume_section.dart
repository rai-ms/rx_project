import 'package:flutter/material.dart';
import 'package:rx_project/core/constants/app_colors.dart';
import 'package:rx_project/core/services/firebase_service/firestore_service.dart';
import 'package:rx_project/features/widget/common/custom_text_field.dart';
import 'package:rx_project/features/widget/common/primary_button.dart';


class ResumeSettings extends StatefulWidget {
  const ResumeSettings({super.key});

  @override
  State<ResumeSettings> createState() => _ResumeSettingsState();
}

class _ResumeSettingsState extends State<ResumeSettings> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  bool _isLoading = false;
  bool _showResumeViaLink = false;

  @override
  void initState() {
    super.initState();
    _loadResumeSettings();
  }

  Future<void> _loadResumeSettings() async {
    setState(() => _isLoading = true);
    try {
      final data = await FirestoreService().getResumeData();
      if (mounted) {
        _urlController.text = data.resumeUrl;
        setState(() => _showResumeViaLink = data.showResumeViaLink);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load resume settings: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveResumeSettings() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await FirestoreService().updateResumeData(
        resumeUrl: _urlController.text.trim(),
        showResumeViaLink: _showResumeViaLink,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Resume settings updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update resume settings: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resume Settings',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _urlController,
                    label: 'Resume URL',
                    hint: 'Enter Google Drive or direct PDF URL',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a URL';
                      }
                      if (!Uri.tryParse(value)!.hasAbsolutePath) {
                        return 'Please enter a valid URL';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text(
                      'Show resume as link only',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      'If enabled, users will see a download link instead of an embedded viewer',
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: _showResumeViaLink,
                    onChanged: (value) {
                      setState(() {
                        _showResumeViaLink = value;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      onPressed: _saveResumeSettings,
                      text: 'Save Changes',
                      isLoading: _isLoading,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
