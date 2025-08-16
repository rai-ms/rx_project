part of 'projects_bloc.dart';

class ProjectsState extends BlocEventState<List<HomeProjectModel>> {
  const ProjectsState({
    super.data,
    super.error,
    super.event,
    super.state,
    super.statusCode,
  });

  @override
  ProjectsState clear() => ProjectsState();

  @override
  ProjectsState copyWith({
    List<HomeProjectModel>? data,
    String? error,
    BlocEvent? event,
    BlocState? state,
    int? statusCode,
  }) {
    return ProjectsState(
      data: data ?? this.data,
      error: error ?? this.error,
      event: event ?? this.event,
      state: state ?? this.state,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
