import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/core/constants/app_colors.dart';
import 'package:rx_project/core/constants/app_text.dart';
import 'package:rx_project/core/services/route_service/route_names.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key, 
    required this.padding,
    this.isAdmin = false,
    required this.scaffoldKey,
  });

  final EdgeInsets padding;
  final bool isAdmin;
  final GlobalKey<ScaffoldState> scaffoldKey;

  void _navigateTo(BuildContext context, String route) {
    context.go(route);
  }

  Widget _buildNavLink(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () => _navigateTo(context, route),
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
      onPressed: () => _navigateTo(context, RouteName.admin),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: Colors.purple.withValues(alpha: 0.1),
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
            AppText.navAdmin,
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
        decoration: const BoxDecoration(
          color: Color(0xFF0A0A0A),
        ),
        padding: padding,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 900;
            final isMediumScreen = constraints.maxWidth > 600 && constraints.maxWidth <= 900;
            
            return Row(
              children: [
                // Logo and Title
                InkWell(
                  splashFactory: InkSplash.splashFactory,
                  highlightColor: AppColors.transparent,
                  focusColor: AppColors.transparent,
                  onTap: () => context.go(RouteName.home),
                  child: Row(
                    children: [
                      const Icon(Icons.memory, color: Colors.white, size: 20),
                      if (constraints.maxWidth > 400) ...[  // Only show text if there's enough space
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
                    ],
                  ),
                ),
                const Spacer(),
                // Navigation Links - Responsive based on screen size
                if (isWideScreen)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildNavLink(context, AppText.navWork, RouteName.home),
                      const SizedBox(width: 24),
                      _buildNavLink(context, AppText.navAbout, RouteName.aboutScreen),
                      const SizedBox(width: 24),
                      _buildNavLink(context, AppText.navContact, RouteName.contactScreen),
                      const SizedBox(width: 24),
                      _buildAdminButton(context),
                      const SizedBox(width: 24),
                      // Resume Button
                      ElevatedButton(
                        onPressed: () => context.go(RouteName.resumeScreen),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF303030),
                          minimumSize: const Size(84, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          AppText.navResume,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.015,
                          ),
                        ),
                      ),
                    ],
                  )
                else if (isMediumScreen)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildNavLink(context, AppText.navWork, RouteName.home),
                      const SizedBox(width: 16),
                      _buildNavLink(context, AppText.navAbout, RouteName.aboutScreen),
                      const SizedBox(width: 16),
                      _buildNavLink(context, AppText.navContact, RouteName.contactScreen),
                      const SizedBox(width: 16),
                      _buildAdminButton(context),
                      const SizedBox(width: 16),
                      // Smaller Resume Button
                      ElevatedButton(
                        onPressed: () => context.go(RouteName.resumeScreen),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF303030),
                          minimumSize: const Size(80, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Resume',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
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
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
