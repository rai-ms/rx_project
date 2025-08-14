import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/features/widget/header/app_header.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: AppHeader(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    title: project['title']!,
                    description: project['description']!,
                    technologies: project['technologies'] as List<String>,
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
    );
  }

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Telecom Mobile App',
      'description': 'A comprehensive telecom application with features like bill payments, data packs, and customer support.',
      'technologies': ['Flutter', 'Dart', 'Bloc', 'REST API'],
    },
    {
      'title': 'E-Commerce App',
      'description': 'A full-featured e-commerce application with product catalog, cart, and payment integration.',
      'technologies': ['Flutter', 'Provider', 'Firebase', 'Stripe'],
    },
    {
      'title': 'Music Streaming App',
      'description': 'A music streaming application with offline playback and playlist management.',
      'technologies': ['Flutter', 'GetX', 'SQLite', 'Audio Service'],
    },
    {
      'title': 'Fitness Tracker',
      'description': 'A health and fitness tracking application with workout plans and progress tracking.',
      'technologies': ['Flutter', 'Riverpod', 'Health Kit', 'Firebase'],
    },
    {
      'title': 'Food Delivery App',
      'description': 'A food delivery application with real-time order tracking and restaurant listings.',
      'technologies': ['Flutter', 'Bloc', 'Google Maps', 'Firebase'],
    },
    {
      'title': 'Task Management',
      'description': 'A productivity app for managing tasks, deadlines, and team collaboration.',
      'technologies': ['Flutter', 'MobX', 'Hive', 'GetIt'],
    },
  ];
}
