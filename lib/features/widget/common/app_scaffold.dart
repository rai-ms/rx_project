import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:go_router/go_router.dart';
import 'package:rx_project/core/constants/app_text.dart';
import 'package:rx_project/core/services/route_service/route_names.dart';
import 'package:rx_project/features/admin/presentation/manager/profile_manage_bloc/profile_manage_bloc.dart';

import 'app_header.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.sliverListBuilder,
    this.isAdmin = false,
    this.showHeader = true,
  });

  final SliverListBuilder sliverListBuilder;
  final bool isAdmin;
  final bool showHeader;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0A0A0A),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF1A1A1A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0A0A0A),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppText.menu,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white70),
              title: Text(AppText.navWork, style: TextStyle(color: Colors.white)),
              onTap: () {
                _scaffoldKey.currentState?.closeDrawer();
                context.go(RouteName.home);
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: Colors.white70),
              title: Text(AppText.navAdmin, style: TextStyle(color: Colors.white)),
              onTap: () {
                _scaffoldKey.currentState?.closeDrawer();
                context.go(RouteName.admin);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white70),
              title: Text(AppText.navAbout, style: TextStyle(color: Colors.white)),
              onTap: () {
                _scaffoldKey.currentState?.closeDrawer();
                context.go(RouteName.aboutScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.white70),
              title: Text(AppText.navContact, style: TextStyle(color: Colors.white)),
              onTap: () {
                _scaffoldKey.currentState?.closeDrawer();
                context.go(RouteName.contactScreen);
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProfileManageBloc, ProfileManageState>(
        builder: (context, ProfileManageState profileManageState) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 864;
              return ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: CustomScrollView(
                  slivers: [
                    if (widget.showHeader)
                      AppHeader(
                        padding: padding(isWide),
                        isAdmin: widget.isAdmin,
                        scaffoldKey: _scaffoldKey,
                      ),
                    ...widget.sliverListBuilder(context, isWide, profileManageState.isLoading).map(
                          (widget) =>
                          SliverPadding(
                            padding: padding(isWide),
                            sliver: widget,
                          ),

                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  EdgeInsets padding(bool isWide) =>
      EdgeInsets.symmetric(
        horizontal: isWide ? 120 : 20,
        vertical: 20,
      );
}

typedef SliverListBuilder = List<
    Widget> Function(BuildContext context, bool isWide, bool isloading);