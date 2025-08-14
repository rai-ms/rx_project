import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_text.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../widget/header/app_header.dart';
import '../widgets/skill_chip.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 864;
            return Padding(
              padding: EdgeInsets.symmetric( horizontal: isWide ?120 : 20, vertical: 20),
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: CustomScrollView(
                slivers: [
                  const AppHeader(),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Section
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                AppText.aboutName,
                                style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.015,
                                ),
                              ),
                              Text(
                                AppText.aboutJobTitle,
                                style: GoogleFonts.workSans(
                                  color: const Color(0xFFABABAB),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                AppText.aboutLocation,
                                style: GoogleFonts.workSans(
                                  color: const Color(0xFFABABAB),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // About Text
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            AppText.aboutBio,
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
                        _buildSectionTitle(AppText.skillsTitle),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            for (final skill in AppText.skills.take(4)) SkillChip(label: skill),
                          ],
                        ),

                        // Skill Progress Bars
                        _buildSkillProgress(AppText.uiUxDesign, 90),
                        _buildSkillProgress(AppText.interactionDesign, 85),
                        _buildSkillProgress(AppText.visualDesign, 80),
                        _buildSkillProgress(AppText.prototyping, 75),

                        // Experience Section
                        _buildSectionTitle(AppText.experienceTitle),
                        _buildExperienceItem(
                          title: AppText.exp1Title,
                          period: AppText.exp1Period,
                        ),
                        _buildExperienceItem(
                          title: AppText.exp2Title,
                          period: AppText.exp2Period,
                        ),
                        _buildExperienceItem(
                          title: AppText.exp3Title,
                          period: AppText.exp3Period,
                          isLast: true,
                        ),

                        // Projects Section
                        _buildSectionTitle(AppText.projectsTitle),
                        const SizedBox(height: 12),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                          children: [
                            for (final project in AppText.projectTitles) _buildProjectCard(project),
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
                              AppText.viewAllProjectsButton,
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
                ],
                            ),
              ),
          );
        }
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