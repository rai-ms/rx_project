import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rx_project/features/about/presentation/pages/about_page.dart';
import 'package:rx_project/features/contact/presentation/pages/contact_page.dart';
import 'package:rx_project/features/home/presentation/pages/home_page.dart';
import 'package:rx_project/features/resume/presentation/pages/resume_page.dart';

/// A class that holds route names.
///
/// This class provides a central place for all route names in the app.
class RouteNames {
  static const String home = '/';
  static const String about = '/about';
  static const String resume = '/resume';
  static const String contact = '/contact';

  /// Private constructor to prevent instantiation.
  const RouteNames._();
}

/// A class that holds route configurations.
class AppRoutes {
  /// The list of routes used by the app.
  static final List<RouteBase> routes = [
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      pageBuilder: (ctx, state) => NoTransitionPage(child: HomePage())
    ),
    GoRoute(
      path: RouteNames.about,
      name: RouteNames.about,
      pageBuilder: (ctx, state) => NoTransitionPage(child: AboutPage())
    ),
    GoRoute(
      path: RouteNames.resume,
      name: RouteNames.resume,
      pageBuilder: (ctx, state) => NoTransitionPage(child: ResumePage()),
    ),
    GoRoute(
      path: RouteNames.contact,
      name: RouteNames.contact,
      pageBuilder: (ctx, state) => NoTransitionPage(child: ContactPage()),
    ),
  ];

  /// Private constructor to prevent instantiation.
  const AppRoutes._();
}

/// The main router configuration for the app.
final router = GoRouter(
  initialLocation: RouteNames.home,
  routes: AppRoutes.routes,
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);
