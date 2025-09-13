import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rx_project/core/base/base_service/base_service.dart'
    show BaseService;
import 'package:rx_project/core/utils/app_style.dart'
    show AppStyles, TextStyling;
import 'package:rx_project/features/privacy/presentation/pages/privacy_policy_page.dart';
import '../../../features/about/presentation/pages/about_page.dart';
import '../../../features/admin/presentation/pages/admin_dashboard.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/contact/presentation/pages/contact_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/projects/presentation/pages/projects_page.dart';
import '../../../features/resume/presentation/pages/resume_page.dart';
import '../firebase_service/auth_service.dart';
import 'route_names.dart';
import '../../base/logger/app_logger_impl.dart';

@protected
@immutable
class RouteService extends BaseService<void, void> {
  static final RouteService routeService = RouteService();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'mainNavigation');

  @override
  void init({void param}) {
    log.d("RouteService Initialized");
  }

  final GoRouter goRouter = GoRouter(
    initialLocation: RouteName.home,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    observers: [BotToastNavigatorObserver()],
    redirect: (context, state) {
      log.d(state.uri.path);
      return null;
    },
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text("Link Broken", style: AppStyles.medium.medium.red),
        ),
      );
    },
    routes: <RouteBase>[
      GoRoute(
        path: RouteName.home,
        name: RouteName.home,
        pageBuilder: (ctx, state) => NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        path: RouteName.aboutScreen,
        name: RouteName.aboutScreen,
        pageBuilder: (ctx, state) => NoTransitionPage(child: AboutPage()),
      ),
      GoRoute(
        path: RouteName.resumeScreen,
        name: RouteName.resumeScreen,
        pageBuilder: (ctx, state) => NoTransitionPage(child: ResumePage()),
      ),
      GoRoute(
        path: RouteName.privacyPolicy,
        name: RouteName.privacyPolicy,
        pageBuilder: (ctx, state) => NoTransitionPage(child: PrivacyPolicyPage()),
      ),
      GoRoute(
        path: RouteName.contactScreen,
        name: RouteName.contactScreen,
        pageBuilder: (ctx, state) => NoTransitionPage(child: ContactPage()),
      ),
      GoRoute(
        path: RouteName.projects,
        name: RouteName.projects,
        pageBuilder: (ctx, state) => NoTransitionPage(child: ProjectsPage()),
      ),
      GoRoute(
        path: RouteName.loginScreen,
        name: RouteName.loginScreen,
        pageBuilder: (ctx, state) => NoTransitionPage(child: const LoginPage()),
      ),
      GoRoute(
        path: RouteName.admin,
        name: RouteName.admin,
        pageBuilder: (ctx, state) =>
            NoTransitionPage(child: const AdminDashboard()),
        redirect: (context, state) {
          final authService = AuthService();
          if (!authService.isAdmin) {
            return RouteName.loginScreen;
          }
          return null;
        },
      ),
    ],
  );
}
