import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:rx_project/features/admin/presentation/manager/profile_manage_bloc/profile_manage_bloc.dart';

import 'app_header.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.sliverListBuilder,
    this.isAdmin = false,
  });

  final SliverListBuilder sliverListBuilder;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocBuilder<ProfileManageBloc, ProfileManageState>(
        builder: (context, ProfileManageState profileManageState) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 864;
              return ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: CustomScrollView(
                  slivers: [
                    AppHeader(
                      padding: padding(isWide),
                      isAdmin: isAdmin,
                    ),
                    ...sliverListBuilder(context, isWide, profileManageState.isLoading).map(
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