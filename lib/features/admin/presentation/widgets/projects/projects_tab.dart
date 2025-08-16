import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rx_project/features/admin/domain/model/request/home_project_model.dart' show HomeProjectModel;
import 'package:rx_project/features/admin/presentation/widgets/projects/project_form_dialog.dart';
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
             if(state.isFailed){
                return Center(
                  child: Text(
                    'Failed to load projects',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              }
             return Column(
               children: [
                 ProjectsListView(
                   projects: state.data ?? [],
                 ),
                 if(state.isLoading )Center(child: CircularProgressIndicator())
               ],
             );
            }
          ),
        ),
        IconButton(
          onPressed: () async {
            var model = await showCupertinoDialog(
              context: context,
              builder: (ctx) => ProjectFormDialog(
                onImageUpload: (){},
                onSubmit: (model, file){
                  if(file != null) {
                    // context.read<ProjectsBloc>().add(
                    //   UploadProjectImageEvent(file: file, addProjectsEvent: AddProjectsEvent(project: model), projectId: model.id ?? "")
                    // );
                    // context.read<ProjectsBloc>().add(
                    //     AddProjectsEvent(project: model)
                    // );
                  }
                }
              )
            );

            if(model is HomeProjectModel && context.mounted) {
              context.read<ProjectsBloc>().add(
                AddProjectsEvent(project: model)
            );
            }
          }, icon: Icon(Icons.add)
        )
      ],
    );
  }
}
