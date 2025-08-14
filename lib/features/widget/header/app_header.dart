

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/core/routes/app_router.dart';

import '../../../core/utils/app_colors.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      floating: false,
      automaticallyImplyLeading: false,
      toolbarHeight: 72,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.darkCharcoal
            )
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          child: Row(
            children: [
              // Logo and Title
              InkWell(
                onTap: (){
                  context.go(RouteNames.home);
                },
                child: Row(
                  children: [
                    const Icon(Icons.memory, color: Colors.white, size: 20),
                    const SizedBox(width: 16),
                    Text(
                      'Portfolio',
                      style: GoogleFonts.workSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: -0.015 * 18,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Navigation Links - Hide on small screens
              if (MediaQuery.of(context).size.width > 600) 
                Row(
                  children: [
                    _buildNavLink(context, 'Home', RouteNames.home),
                    const SizedBox(width: 36),
                    _buildNavLink(context, 'About', RouteNames.about),
                    const SizedBox(width: 36),
                    _buildNavLink(context, 'Contact', RouteNames.contact),
                    const SizedBox(width: 36),
                    // Resume Button
                    ElevatedButton(
                      onPressed: () => context.go(RouteNames.resume),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF303030),
                        minimumSize: const Size(84, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Resume',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.015,
                        ),
                      ),
                    ),
                  ],
                )
              else
                // Show menu button on small screens
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    // Handle menu button press (you can show a drawer or bottom sheet)
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildNavLink(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () {
        context.go(route);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: GoogleFonts.workSans(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ),
    );
  }
}
