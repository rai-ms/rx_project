

import 'package:flutter/material.dart';

import 'app_header.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.sliverListBuilder});
  final SliverListBuilder sliverListBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 864;
          return ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(scrollbars: false),
            child: CustomScrollView(
              slivers: [
                AppHeader(padding: padding(isWide)),
                ...sliverListBuilder(context, isWide).map(
                  (widget) => SliverPadding(
                    padding: padding(isWide),
                    sliver: widget,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  EdgeInsets padding(bool isWide) => EdgeInsets.symmetric(
      horizontal: isWide ? 120 : 20,
      vertical: 20,
    );
}

typedef SliverListBuilder = List<Widget> Function(BuildContext context, bool isWide);