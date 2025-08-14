import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location == '/') return 0;
    if (location.startsWith('/about')) return 1;
    if (location.startsWith('/resume')) return 2;
    if (location.startsWith('/contact')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/about');
        break;
      case 2:
        context.go('/resume');
        break;
      case 3:
        context.go('/contact');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: const HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _buildNavLink(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () {
        // Navigate using Go Router
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

  Widget _buildProjectCard(String title, String description, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: GoogleFonts.workSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        Text(
          description,
          style: GoogleFonts.workSans(
            color: const Color(0xFFABABAB),
            fontSize: 14,
            fontWeight: FontWeight.normal,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
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
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 864;
                    return Flex(
                      direction: isWide ? Axis.horizontal : Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image
                        if (isWide) ...[
                          Expanded(
                            flex: 5,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/profile_image.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 32),
                        ],
                        // Profile Info
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isWide) ...[
                                const SizedBox(height: 32),
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBWW2ak_K_AXiu79OwCNYHQFmGgiRj_3SZcMORMuovkqlsNVWyy6_CeUIAHzojzkvIhZDM0bj5XlFOM-wYjOWLK8BHNkFKVfNM3uZyGwR0hjPGFfTg4PP-gfxtkwkbco_RrBjqGad_wk3nhG6MPxxDBptB87jjbpGJLQpdWISWfk0dsZFFSSfBQB-U6iRhn7ayJxUFqKyvA1MvTmA2Edhn6HaAS20UW3LyOBTj1-ViN29k_y9JE2gS3a5m4lhiNiLeGrUMU3mQnLxo',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                              Text(
                                'Ashish Rai',
                                style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                  letterSpacing: -0.033,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Flutter Developer',
                                style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: () {
                                  // Action for View My Work button
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF262626),
                                  minimumSize: const Size(340, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'View My Work',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.015,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // Experience Text
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                    '2 years of experience building scalable, cross-platform applications',
                    style: GoogleFonts.workSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                    ),
                  ),
                ),

                // Featured Projects
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 20,
                    bottom: 12,
                  ),
                  child: Text(
                    'Featured Projects',
                    style: GoogleFonts.workSans(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                      letterSpacing: -0.015,
                    ),
                  ),
                ),

                // Projects Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth ~/ 200;
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount < 1 ? 1 : crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildProjectCard(
                          'Project Alpha',
                          'A mobile app for fitness enthusiasts',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCU8PpvPzAePRVOfCKqgWsx89teW5QBo88r22v3PRsrtw2owtV1Guogry_oFc0d-TJRZnSR_OFzc8FiVZSG3phBm7fbUinK2WOkqH5Bl8OUk9JzLGaIXlA0JtrJ-JCotZsaqloMC_pHMUZyGgDAWi5dJjoqk4ep1dBwiU38uITdt1yEAf2B6gJVKqbikLzyWJbAdaxn9I7CUsJjC1r84yZXj8ilLlmQo4dgNOB4uYV3wrSn6jXUMxlUqxUwBv6JIHYR9VBBhsXlugw',
                        ),
                        _buildProjectCard(
                          'Project Beta',
                          'A web platform for online learning',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCKeizBqxW8MnSnadXQy35c_tL1Sm6oRi3BoQ9Mn7q9Gklm4y-9rkcE0Y4TTUQeOTEfylzpDC-7CkrcaSbHUvkyHacD33bB_6AModR9VmkZ_6QqScmZ-DMN25xl_7F2XHBdumVJ_LQZMb4l9C1PCkiOF2m3dfRzHNXq0GXVRWlud-r7Oc2SyarmRK8g2Fh_wXvgaB82hkOTk3z3qflw2UY24wPK-Y4E61aDneBb8lFg3wskFKPBpDZZBJFy0M2d4pEouK-sX3KvDsU',
                        ),
                        _buildProjectCard(
                          'Project Gamma',
                          'An e-commerce site for sustainable products',
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDhE02s4WRdJyEyCE0R8LSYyw18bqws08zDuqhuiiO0Qva5fxusYcLQU-JAPUp7JROVRL40Da4IawDeuklaCHFfF1DX0cepZMmcgXXagHDGuz9LvlC0zDA_G5vNb9sqJGh_1DoqX7iWycA6zsQ1sOmS2DFTFFs7rUfIGfn6Uo-MJWSqP1I2c0qMuI-iwqMjp-PMloLV7c0qkY3CpmD4GoL8oWweYex0wd_2N9l2sZPqSt-ZqXSh7xVux_aIxS--7M99XFwWGG_QSho',
                        ),
                      ],
                    );
                  },
                ),

                // View All Projects Button
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for View All Projects button
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF303030),
                        minimumSize: const Size(160, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View All Projects',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.015,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
