import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/image_constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Column(
                children: [
                  // Profile Image
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(
                          ImageConstants.profileImage
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Name and Title
                  Text(
                    'Sophia Bennett',
                    style: GoogleFonts.workSans(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.015,
                    ),
                  ),
                  Text(
                    'Product Designer',
                    style: GoogleFonts.workSans(
                      color: const Color(0xFFABABAB),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'Based in San Francisco',
                    style: GoogleFonts.workSans(
                      color: const Color(0xFFABABAB),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),

              // About Text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  "I'm a product designer passionate about creating intuitive and engaging user experiences. With a background in visual communication and a focus on user-centered design, I strive to solve complex problems through simple and elegant solutions.",
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Skills Section
              _buildSectionTitle('Skills'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildSkillChip('Flutter'),
                  _buildSkillChip('Dart'),
                  _buildSkillChip('Firebase'),
                  _buildSkillChip('UI/UX Design'),
                ],
              ),

              // Skill Progress Bars
              _buildSkillProgress('UI/UX Design', 90),
              _buildSkillProgress('Interaction Design', 85),
              _buildSkillProgress('Visual Design', 80),
              _buildSkillProgress('Prototyping', 75),

              // Experience Section
              _buildSectionTitle('Experience'),
              _buildExperienceItem(
                title: 'Product Designer at Tech Innovators Inc.',
                period: '2020 - Present',
              ),
              _buildExperienceItem(
                title: 'UI/UX Designer at Creative Solutions Co.',
                period: '2018 - 2020',
              ),
              _buildExperienceItem(
                title: 'Freelance Designer',
                period: '2016 - 2018',
                isLast: true,
              ),

              // Projects Section
              _buildSectionTitle('Projects'),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
                children: [
                  _buildProjectCard('Mobile App Redesign'),
                  _buildProjectCard('E-commerce Website'),
                  _buildProjectCard('Dashboard Design'),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF303030),
                    minimumSize: const Size(160, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View All Projects',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12, left: 4, right: 4),
      child: Text(
        title,
        style: GoogleFonts.workSans(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.015,
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.workSans(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSkillProgress(String skill, int percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: GoogleFonts.workSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$percentage%',
                style: GoogleFonts.workSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF474747),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem({
    required String title,
    required String period,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.work_outline,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.workSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      period,
                      style: GoogleFonts.workSans(
                        color: const Color(0xFFABABAB),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    if (!isLast) const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
          if (!isLast) const Divider(color: Color(0xFF474747), height: 32),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: GoogleFonts.workSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}