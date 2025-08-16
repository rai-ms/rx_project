import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/utils/app_type_def.dart';
import '../../../../../core/base/bloc_base/bloc_event.dart';
import '../../../../../core/base/bloc_base/bloc_event_state.dart';
import '../../../domain/model/request/home_project_model.dart'
    show HomeProjectModel;

part 'projects_event.dart';
part 'projects_state.dart';

@injectable
class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(ProjectsState()) {
    on<FetchProjectsEvent>(_fetchProjects);
    on<AddProjectsEvent>(_addProjects);
  }

  FVoid _fetchProjects(ProjectsEvent event,  Emitter<ProjectsState> emit) async {


    
  }


  FVoid _addProjects(AddProjectsEvent event,  Emitter<ProjectsState> emit) async {

  }
}
