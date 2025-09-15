import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/core/constants/app_colors.dart';
import 'package:rx_project/features/widget/common/app_scaffold.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showHeader: false,
      sliverListBuilder: (context, isWide, isLoading) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 120 : 32,
                vertical: 40,
              ),
              child: _buildPrivacyPolicyContent(),
            ),
          ),
        ];
      },
    );
  }

  Widget _buildPrivacyPolicyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy Policy',
          style: GoogleFonts.workSans(
            color: AppColors.whiteColor,
            fontSize: 48,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        _buildSection(
          title: '1. Information We Collect',
          content:
              'We may collect personal information such as your name, email address, and other contact details when you interact with our services. We also collect non-personal information like usage data, device information, and cookies to improve our services.',
        ),
        _buildSection(
          title: '2. How We Use Your Information',
          content:
              'We use the information we collect to provide, maintain, and improve our services, communicate with you, and ensure the security of our platform. Your information helps us personalize your experience and develop new features.',
        ),
        _buildSection(
          title: '3. Data Security',
          content:
              'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet is 100% secure.',
        ),
        _buildSection(
          title: '4. Third-Party Services',
          content:
              'We may employ third-party companies and individuals to facilitate our services, provide services on our behalf, or assist us in analyzing how our services are used. These third parties have access to your personal information only to perform these tasks and are obligated not to disclose or use it for any other purpose.',
        ),
        _buildSection(
          title: '5. Cookies and Tracking',
          content:
              'We use cookies and similar tracking technologies to track activity on our service and hold certain information. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent.',
        ),
        _buildSection(
          title: '6. Your Data Protection Rights',
          content:
              'Depending on your location, you may have rights including accessing, updating, or deleting your personal information. You can also object to or restrict certain processing of your data.',
        ),
        _buildSection(
          title: '7. Changes to This Policy',
          content:
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
        ),
        _buildSection(
          title: '8. Contact Us',
          content:
              'If you have any questions about this Privacy Policy, please contact us through the contact information provided in our app or website.',
        ),
        const SizedBox(height: 40),
        Text(
          'Last Updated: September 13, 2025',
          style: GoogleFonts.workSans(
            color: AppColors.greyColor.withValues(alpha: 0.7),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.workSans(
              color: AppColors.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.workSans(
              color: AppColors.greyColor.withValues(alpha: 0.7),
              fontSize: 16,
              fontWeight: FontWeight.normal,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
