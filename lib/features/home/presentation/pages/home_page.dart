import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rx_project/features/admin/presentation/manager/profile_manage_bloc/profile_manage_bloc.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../admin/presentation/manager/projects_bloc/projects_bloc.dart'
    show ProjectsBloc, FetchProjectsEvent, ProjectsState;
import '../../../widget/common/app_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    context.read<ProfileManageBloc>().add(LoadUserProfileEvent());
    context.read<ProjectsBloc>().add(FetchProjectsEvent());
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
                image: AssetImage(imageUrl),
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

  Widget _buildProfileSection(bool isWide) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ProfileManageBloc, ProfileManageState>(
        builder: (ctx, ProfileManageState profileState) {
          var user = profileState.data;
          return LayoutBuilder(
            builder: (ctx2, constraints) {
              final isWide = constraints.maxWidth >= 864;
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 120 : 80, vertical: 40),
                child: Flex(
                  direction: isWide ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    if (isWide) ...[
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage(ImageConstants.profileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                    // Profile Info
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isWide) ...[
                          Container(
                            height: 200,
                            width: 200,
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage(ImageConstants.profileImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                        Text(
                          user?.fullName ?? AppText.homeTitle,
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
                          user?.role ?? AppText.homeSubtitle,
                          style: GoogleFonts.workSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: 340,
                          child: ElevatedButton(
                            onPressed: () {
                              // Action for View My Work button
                              context.goNamed(RouteNames.projects);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF262626),
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              AppText.viewWorkButton,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.015,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildExperienceSection() {
    return SliverToBoxAdapter(
      child: BlocBuilder<ProfileManageBloc, ProfileManageState>(
        builder: (ctx, ProfileManageState profileState) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              profileState.data?.bio ?? AppText.experienceText,
              style: GoogleFonts.workSans(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.5,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectsSection() {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        return SliverLayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = (constraints.crossAxisExtent / 300)
                .floor()
                .clamp(1, 3);
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildListDelegate([
                if(state.isLoading) Center(child: CircularProgressIndicator(),),
                if(state.data?.isNotEmpty ?? false) ...List.generate(state.data?.length ?? 0, (index) => _buildProjectCard(
                  state.data?[index].name ?? "N/A",
                  state.data?[index].description ?? "N/A",
                  state.data?[index].imageUrl ?? "N/A",
                )),
              ]),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      sliverListBuilder: (_, isWide, isLoading) {
        if (isLoading) {
          return [
            SliverToBoxAdapter(
              child: SizedBox(
                height: Space.h(context),
                width: Space.w(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ];
        }
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                AppText.featuredProjects,
                style: GoogleFonts.workSans(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  letterSpacing: -0.015,
                ),
              ),
            ),
          ),
          _buildProfileSection(isWide),
          _buildExperienceSection(),
          _buildProjectsSection(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(RouteNames.projects);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF303030),
                    minimumSize: const Size(160, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    AppText.viewAllProjects,
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
          ),
        ];
      },
    );
  }
}
