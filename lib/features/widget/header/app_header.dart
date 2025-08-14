

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFF303030))),
        ),
        child: Row(
          children: [
            // Logo and Title
            Row(
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
            const Spacer(),
            // Navigation Links
            Row(
              children: [
                _buildNavLink(context, 'Work', '/'),
                const SizedBox(width: 36),
                _buildNavLink(context, 'About', '/about'),
                const SizedBox(width: 36),
                _buildNavLink(context, 'Contact', '/contact'),
                const SizedBox(width: 36),
                // Resume Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to resume page using Go Router
                    context.go('/resume');
                  },
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
            ),
          ],
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
