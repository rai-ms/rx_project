import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rx_project/core/constants/app_colors.dart';
import 'package:rx_project/core/routes/app_router.dart';
import 'package:rx_project/core/services/firebase_service/auth_service.dart';
import 'package:rx_project/features/widget/common/app_scaffold.dart';
import '../widgets/widgets.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    await AuthService().signOut();
    if (confirmed == true) {
      if (mounted) {
        context.goNamed(RouteNames.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isAdmin: true,
      sliverListBuilder: (ctx, isWide, isLoading) {
        return [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header with Logout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Admin Dashboard',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white),
                        onPressed: _handleLogout,
                        tooltip: 'Logout',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Tabs
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.primary,
                    ),
                    tabs: const [
                      Tab(text: 'Home'),
                      Tab(text: 'About'),
                      Tab(text: 'Resume'),
                      Tab(text: 'Contact'),
                      Tab(text: 'Projects'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Tab content
                _buildCurrentTab(),
              ],
            ),
          ),
        ];
      },
    );
  }

  Widget _buildCurrentTab() {
    switch (_currentTabIndex) {
      case 0:
        return const HomeTab();
      case 1:
        return const AboutTab();
      case 2:
        return const ResumeTab();
      case 3:
        return const ContactTab();
      case 4:
        return const ProjectsTab();
      default:
        return const SizedBox.shrink();
    }
  }
}
