import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/features/widget/header/app_header.dart';

import '../../../../core/constants/image_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
                fit: BoxFit.fill,
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Content

            AppHeader(),

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
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        ImageConstants.profileImage
                                    ),
                                    fit: BoxFit.fill,
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
                                  Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            ImageConstants.profileImage
                                        ),
                                        fit: BoxFit.fill,
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
      ),
    );
  }
}
