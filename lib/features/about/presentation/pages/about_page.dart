import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_text.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/routes/app_router.dart';
import '../../../widget/header/app_header.dart';
import '../widgets/skill_chip.dart';
import '../widgets/skill_progress_bar.dart';
import '../widgets/experience_item.dart';
import '../widgets/section_title.dart';
import '../widgets/project_card.dart';

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
                        SectionTitle(title: AppText.skillsTitle),
                        const SizedBox(height: 12),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: 500
                          ),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  for (final skill in AppText.skills.take(4)) SkillChip(label: skill),
                                ],
                              ),
                              // Skill Progress Bars
                              SkillProgressBar(skill: AppText.uiUxDesign, percentage: 90),
                              SkillProgressBar(skill: AppText.interactionDesign, percentage: 85),
                              SkillProgressBar(skill: AppText.visualDesign, percentage: 80),
                              SkillProgressBar(skill: AppText.prototyping, percentage: 75),
                            ],
                          ),
                        ),


                        // Experience Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 500
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SectionTitle(title: AppText.experienceTitle),
                                    // ExperienceItem(
                                    //   title: AppText.exp1Title,
                                    //   period: AppText.exp1Period,
                                    // ),
                                    // ExperienceItem(
                                    //   title: AppText.exp2Title,
                                    //   period: AppText.exp2Period,
                                    // ),
                                    ExperienceItem(
                                      title: AppText.exp3Title,
                                      period: AppText.exp3Period,
                                      isLast: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Projects Section
                        SectionTitle(title: AppText.projectsTitle),
                        const SizedBox(height: 12),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                          children: [
                            for (final project in AppText.projectTitles) ProjectCard(title: project),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              context.goNamed(RouteNames.projects);
                            },
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


}