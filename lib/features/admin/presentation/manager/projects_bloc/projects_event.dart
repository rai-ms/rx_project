part of 'projects_bloc.dart';

class ProjectsEvent extends BlocEvent {
  const ProjectsEvent();
}

class FetchProjectsEvent extends ProjectsEvent {
  const FetchProjectsEvent();
}

class AddProjectsEvent extends ProjectsEvent {
  final HomeProjectModel project;

  const AddProjectsEvent({required this.project});
}

class UpdateProjectsEvent extends ProjectsEvent {
  final HomeProjectModel project;

  const UpdateProjectsEvent({required this.project});
}

class DeleteProjectsEvent extends ProjectsEvent {
  final String projectId;
  const DeleteProjectsEvent({required this.projectId});
}



class UploadProjectImageEvent extends ProjectsEvent {
  final String projectId;
  final XFile file;
  final AddProjectsEvent addProjectsEvent;
  const UploadProjectImageEvent({required this.projectId, required this.file, required this.addProjectsEvent});
}
