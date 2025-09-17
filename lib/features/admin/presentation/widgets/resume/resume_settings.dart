import 'package:flutter/material.dart';

class ResumeSettings extends StatefulWidget {
  const ResumeSettings({super.key});

  @override
  State<ResumeSettings> createState() => _ResumeSettingsState();
}

class _ResumeSettingsState extends State<ResumeSettings> {
  bool _showResumeViaLink = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resume Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resume Display Options',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Show Resume as Download Link Only'),
                    subtitle: const Text(
                        'When enabled, visitors will see a download button instead of the embedded PDF'),
                    value: _showResumeViaLink,
                    onChanged: (value) {
                      setState(() {
                        _showResumeViaLink = value;
                        // TODO: Save this setting to Firestore
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
