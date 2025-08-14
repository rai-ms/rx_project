import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/features/widget/header/app_header.dart';
import '../../domain/models/project_model.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 864;
            return Padding(
              padding: EdgeInsets.symmetric( horizontal: isWide ?120 : 20, vertical: 20),
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child:  CustomScrollView(
                slivers: [
                  AppHeader(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
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
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final project = _projects[index];
                          return ProjectCard(
                            project: project,
                            onTap: () {
                              // Handle project tap
                            },
                          );
                        },
                        childCount: _projects.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 60),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  final List<Project> _projects = [
    Project(
      title: 'Connect Roam',
      description: 'A mobile application for managing telecom services with bill payments and data pack management.',
      technologies: [
        'Cubit', 'REST API', 'Hive', 'Adjust', 'Firebase Storage',
        'Branch IO', 'Google Pay', 'Apple Pay', 'Firebase Analytics',
        'Google Tag Manager', 'Facebook App Events' , 'Tap Payments',
        'Firebase Crashlytics', 'Firebase Cloud Messaging',
      ],
      features: [
        'Bill payments',
        'Data pack management',
        'Customer support chat',
        'Usage analytics',
      ],
      projectUrl: 'https://example.com/telecom-app',
    ),
    Project(
      title: 'DwellSpring',
      description: 'A full-featured e-commerce application with product catalog, cart, and payment integration.',
      technologies: [
        'Bloc', 'just_audio' , 'Tap Payments', 'Hive', 'Secure Storage',
        'Firebase Analytics', 'App Tracking Transparency',
        'Firebase Crashlytics', 'Firebase Cloud Messaging',
      ],
      features: [
        'Product catalog',
        'Shopping cart',
        'Payment processing',
        'Order tracking',
      ],
      projectUrl: 'https://example.com/ecommerce-app',
    ),
    Project(
      title: 'Jarir Bookstore',
      description: 'An online bookstore application with a wide range of books, user reviews, and purchase options.',
      technologies: [
        'Flutter', 'GetX', 'SQLite', 'Firebase Analytics',
        'Firebase Crashlytics', 'Firebase Cloud Messaging',
      ],
      features: [
        'Stream music online',
        'Offline playback',
        'Playlist management',
        'Audio equalizer',
      ],
    ),
    Project(
      title: 'ZitoMedia',
      description: 'A music streaming application that allows users to listen to their favorite tracks online and offline.',
      technologies: [
        'Flutter', 'Provider', 'Health Kit', 'Firebase',
        'Firebase Crashlytics', 'Firebase Cloud Messaging',
      ],
      features: [
        'Workout tracking',
        'Progress analytics',
        'Custom workout plans',
        'Health data sync',
      ],
    ),
  ];
}
