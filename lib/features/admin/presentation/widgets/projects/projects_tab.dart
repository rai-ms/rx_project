import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_project/features/admin/presentation/widgets/projects/projects_list_view.dart';

import '../../manager/projects_bloc/projects_bloc.dart';


class ProjectsTab extends StatefulWidget {
  const ProjectsTab({super.key});

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return CircularProgressIndicator();
        } else if (state.isSuccess) {
          return ProjectsListView(
            projects: state.data ?? [],
          );
        }
        else{
          return Center(
            child: Text(
              'Failed to load projects',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
      }
    );
  }
}
