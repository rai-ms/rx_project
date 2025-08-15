import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rx_project/core/base/base_service/base_service.dart'
    show BaseService;
import 'package:rx_project/core/utils/app_style.dart'
    show AppStyles, TextStyling;
import '../../../features/about/presentation/pages/about_page.dart';
import '../../../features/admin/presentation/pages/admin_dashboard.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/contact/presentation/pages/contact_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/projects/presentation/pages/projects_page.dart';
import '../../../features/resume/presentation/pages/resume_page.dart';
import '../../routes/app_router.dart';
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
    initialLocation: RoutesName.splashScreen,
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
      GoRoute(
        path: RouteNames.projects,
        name: RouteNames.projects,
        pageBuilder: (ctx, state) => NoTransitionPage(child: ProjectsPage()),
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        pageBuilder: (ctx, state) => NoTransitionPage(child: const LoginPage()),
      ),
      GoRoute(
        path: RouteNames.admin,
        name: RouteNames.admin,
        pageBuilder: (ctx, state) => NoTransitionPage(
          child: const AdminDashboard(),
        ),
        redirect: (context, state) {
          final authService = AuthService();
          if (!authService.isAdmin) {
            return RouteNames.login;
          }
          return null;
        },
      ),
    ],
  );

}
