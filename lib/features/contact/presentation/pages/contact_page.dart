import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rx_project/features/widget/header/app_header.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../providers/contact_provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  Widget _buildContactInfo(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // await context.read<ContactProvider>().sendMessage(
      //   name: _nameController.text,
      //   email: _emailController.text,
      //   message: _messageController.text,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 864;
            return Padding(
              padding: EdgeInsets.symmetric( horizontal: isWide ?120 : 20, vertical: 20),
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child:CustomScrollView(
                slivers: [
                  AppHeader(),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Get in Touch',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        _buildContactInfo(
                          context,
                          icon: Icons.email,
                          title: 'Email',
                          subtitle: 'ashishraimse@gmail.com',
                          onTap: () => _launchURL('mailto:ashishraimse@gmail.com'),
                        ),
                        _buildContactInfo(
                          context,
                          icon: Icons.phone,
                          title: 'Phone',
                          subtitle: '+91 7310131004',
                          onTap: () => _launchURL('tel:+917310131004'),
                        ),
                        _buildContactInfo(
                          context,
                          icon: Icons.link,
                          title: 'LinkedIn',
                          subtitle: 'https://www.linkedin.com/in/rai-ms/',
                          onTap: () => _launchURL('https://www.linkedin.com/in/rai-ms/'),
                        ),
                        _buildContactInfo(
                          context,
                          icon: Icons.code,
                          title: 'GitHub',
                          subtitle: 'github.com/rai-ms',
                          onTap: () => _launchURL('https://github.com/rai-ms'),
                        ),
                        const SizedBox(height: 16),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Or send me a message:',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _messageController,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    labelText: 'Message',
                                    border: OutlineInputBorder(),
                                    alignLabelWithHint: true,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your message';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                // if (provider.errorMessage != null)
                                //   Padding(
                                //     padding: const EdgeInsets.only(bottom: 16.0),
                                //     child: Text(
                                //       provider.errorMessage!,
                                //       style: const TextStyle(color: Colors.red),
                                //     ),
                                //   ),
                                // if (provider.isSuccess)
                                //   const Padding(
                                //     padding: EdgeInsets.only(bottom: 16.0),
                                //     child: Text(
                                //       'Message sent successfully!',
                                //       style: TextStyle(color: Colors.green),
                                //     ),
                                //   ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed:_submitForm,
                                    child: Text('Send Message'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
