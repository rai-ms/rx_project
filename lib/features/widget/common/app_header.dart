import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/core/constants/app_colors.dart';
import 'package:rx_project/core/constants/app_text.dart';
import 'package:rx_project/core/routes/app_router.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key, 
    required this.padding,
    this.isAdmin = false,
  });

  final EdgeInsets padding;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF0A0A0A),
      floating: true,
      forceElevated: true,
      foregroundColor: const Color(0xFF0A0A0A),
      automaticallyImplyLeading: false,
      toolbarHeight: 72,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
        ),
        padding: padding,
        child: Row(
          children: [
            // Logo and Title
            InkWell(
              splashFactory: InkSplash.splashFactory,
              highlightColor: AppColors.transparent,
              focusColor: AppColors.transparent,
              onTap: (){
                context.go(RouteNames.home);
              },
              child: Row(
                children: [
                  const Icon(Icons.memory, color: Colors.white, size: 20),
                  const SizedBox(width: 16),
                  Text(
                    AppText.appTitle,
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
                  _buildNavLink(context, AppText.navWork, RouteNames.home),
                  const SizedBox(width: 36),
                  _buildNavLink(context, AppText.navAbout, RouteNames.about),
                  const SizedBox(width: 36),
                  _buildNavLink(context, AppText.navContact, RouteNames.contact),
                  if (isAdmin) ...[
                    const SizedBox(width: 36),
                    _buildAdminButton(context),
                  ],
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
                    child: Text(
                      AppText.navResume,
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

  Widget _buildAdminButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigate to admin dashboard or show admin options
        context.go(RouteNames.admin);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: Colors.purple.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.purple, width: 1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.admin_panel_settings, 
            color: Colors.purple, 
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            'Admin',
            style: GoogleFonts.workSans(
              color: Colors.purple,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
