import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/features/widget/common/app_scaffold.dart';

import '../../../../core/constants/image_constants.dart';
import '../../domain/models/project_model.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      sliverListBuilder: (ctx, isWide, isLoading) {
        return [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'My Projects',
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A collection of my recent work and projects',
                  style: GoogleFonts.workSans(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final project = _projects[index];
              return ProjectCard(
                project: project,
                onTap: () {
                  // Handle project tap
                },
              );
            }, childCount: _projects.length),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
        ];
      },
    );
  }

  final List<Project> _projects = [
    Project(
      title: 'Bloom Employee App',
      imageUrl: null,
      description:
          'Enterprise employee app built from scratch in React Native + Expo (TypeScript) for iOS and Android — SSO, push notifications, internationalization and offline-first storage.',
      technologies: [
        'React Native',
        'TypeScript',
        'Expo',
        'Zustand',
        'React Query',
        'Reanimated',
        'Azure AD SSO',
        'Push Notifications',
        'i18next',
        'MMKV',
        'Keychain',
        'Dynatrace',
        'Jest',
      ],
      features: [
        'Azure AD single sign-on',
        'Push notifications (cold-start on tap)',
        'Full internationalization (i18n)',
        'Offline storage & secure tokens',
      ],
    ),
    Project(
      title: 'Bloom Partner App',
      imageUrl: null,
      description:
          'Companion Partner app in React Native (iOS & Android), sharing the design system and architecture with the Employee app. Live on the App Store and Google Play.',
      technologies: [
        'React Native',
        'TypeScript',
        'Zustand',
        'React Query',
        'REST API',
        'Push Notifications',
        'i18next',
      ],
      features: [
        'Role-based flows',
        'Shared design system',
        'Offline caching',
        'Live on App Store & Google Play',
      ],
      projectUrl:
          "https://play.google.com/store/apps/details?id=com.bloomholding.connect",
    ),
    Project(
      title: 'Connect Roam',
      imageUrl: ImageConstants.connectRoamBg,
      description:
          'A mobile application for managing telecom services with bill payments and data pack management.',
      technologies: [
        'Cubit',
        'REST API',
        'Hive',
        'Adjust',
        'Amplitude',
        'Dynatrace',
        'Firebase Storage',
        'Branch IO',
        'Google Pay',
        'Apple Pay',
        'Firebase Analytics',
        'Google Tag Manager',
        'Facebook App Events',
        'Tap Payments',
        'Firebase Crashlytics',
        'Firebase Cloud Messaging',
      ],
      features: [
        'Bill payments',
        'Data pack management',
        'Customer support chat',
        'Usage analytics',
      ],
      projectUrl: "https://roam.virginconnect.com/",
    ),
    Project(
      title: 'Jarir Bookstore',
      imageUrl: ImageConstants.jarirProjectBg,
      description:
          'An online bookstore application with a wide range of books, user reviews, and purchase options.',
      technologies: [
        'Flutter',
        'GetX',
        'SQLite',
        'Firebase Analytics',
        'Firebase Crashlytics',
        'Firebase Cloud Messaging',
      ],
      features: [
        'Product catalog & search',
        'Secure payment gateways',
        'Localization (Arabic/English)',
        'Order tracking',
      ],
      projectUrl: "https://www.jarir.com/",
    ),
  ];
}
