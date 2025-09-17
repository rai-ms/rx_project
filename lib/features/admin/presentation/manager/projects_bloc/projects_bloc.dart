import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/base/base_use_case/no_params.dart';
import 'package:rx_project/core/base/logger/app_logger_impl.dart';
import 'package:rx_project/core/utils/app_type_def.dart';
import '../../../../../core/base/bloc_base/bloc_event.dart';
import '../../../../../core/base/bloc_base/bloc_event_state.dart';
import '../../../domain/model/request/home_project_model.dart'
    show HomeProjectModel;
import '../../../domain/use_case/project_use_cases.dart';

// Re-export XFile for use in part files
export 'package:image_picker/image_picker.dart' show XFile;

part 'projects_event.dart';
part 'projects_state.dart';

@injectable
class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final CreateProjectUseCase _createProjectUseCase;
  final GetProjectsUseCase _getProjectsUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;
  final UploadProjectImageUseCase _uploadProjectImageUseCase;

  @factoryMethod
  ProjectsBloc(
    this._createProjectUseCase,
    this._getProjectsUseCase,
    this._updateProjectUseCase,
    this._deleteProjectUseCase,
    this._uploadProjectImageUseCase,
  ) : super(ProjectsState()) {
    on<FetchProjectsEvent>(_fetchProjects);
    on<AddProjectsEvent>(_addProject);
    on<UpdateProjectsEvent>(_updateProject);
    on<DeleteProjectsEvent>(_deleteProject);
    on<UploadProjectImageEvent>(_uploadProjectImage);
  }

  FVoid _fetchProjects(
    FetchProjectsEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    if (state.data != null && state.isLoading) {
      Log.d("Projects already loaded, skipping...");
      return;
    }

    emit(state.copyWith(state: state.loading, event: event));
    final result = await _getProjectsUseCase(params: NoParams());

    result.fold(
      (failure) {
        Log.e("GetProjectsUseCase failure: ${failure.message}");
        emit(state.copyWith(error: failure.message, state: state.failed));
      },
      (projects) {
        Log.d("GetProjectsUseCase success: ${projects.length} projects loaded");
        emit(state.copyWith(data: projects, state: state.success));
      },
    );
  }

  FVoid _addProject(AddProjectsEvent event, Emitter<ProjectsState> emit) async {
    emit(state.copyWith(state: state.loading, event: event));
    final result = await _createProjectUseCase(
      params: event.project.copyWith(imageUrl: state.selectedImageUrl),
    );
    result.fold(
      (failure) {
        Log.e("AddProjectUseCase failure: ${failure.message}");
        emit(state.copyWith(error: failure.message, state: state.failed));
      },
      (project) {
        Log.d("AddProjectUseCase success: ${project.toJson()}");
        final updatedProjects = [...?state.data, project];
        emit(state.copyWith(data: updatedProjects, state: state.success));
      },
    );
  }

  FVoid _updateProject(
    UpdateProjectsEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(state: state.loading, event: event));
    final result = await _updateProjectUseCase(params: event.project);

    result.fold(
      (failure) {
        Log.e("UpdateProjectUseCase failure: ${failure.message}");
        emit(state.copyWith(error: failure.message, state: state.failed));
      },
      (updatedProject) {
        Log.d("UpdateProjectUseCase success: ${updatedProject.toJson()}");
        final updatedProjects = state.data
            ?.map((p) => p.id == updatedProject.id ? updatedProject : p)
            .toList();
        emit(state.copyWith(data: updatedProjects, state: state.success));
      },
    );
  }

  FVoid _deleteProject(
    DeleteProjectsEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(state: state.loading, event: event));
    final result = await _deleteProjectUseCase(params: event.projectId);

    result.fold(
      (failure) {
        Log.e("DeleteProjectUseCase failure: ${failure.message}");
        emit(state.copyWith(error: failure.message, state: state.failed));
      },
      (_) {
        Log.d("DeleteProjectUseCase success");
        final updatedProjects = state.data
            ?.where((p) => p.id != event.projectId)
            .toList();
        emit(state.copyWith(data: updatedProjects, state: state.success));
      },
    );
  }

  FVoid _uploadProjectImage(
    UploadProjectImageEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(state.copyWith(isUploadingImage: true, event: event));
    final result = await _uploadProjectImageUseCase(
      params: UploadImageParams(file: event.file, projectId: event.projectId),
    );

    result.fold(
      (failure) {
        Log.e("UploadProjectImageUseCase failure: ${failure.message}");
        emit(state.copyWith(error: failure.message, isUploadingImage: false));
      },
      (imageUrl) {
        Log.d("UploadProjectImageUseCase success: $imageUrl");
        emit(
          state.copyWith(selectedImageUrl: imageUrl, isUploadingImage: false),
        );
        _addProject(event.addProjectsEvent, emit);
      },
    );
  }

  Future<String?> uploadImageUrl(XFile file, String? projectId) async {
    final result = await _uploadProjectImageUseCase(
      params: UploadImageParams(file: file, projectId: projectId),
    );
    String? link;
    result.fold(
      (failure) {
        Log.e("UploadProjectImageUseCase failure: ${failure.message}");
      },
      (imageUrl) {
        Log.d("UploadProjectImageUseCase success: $imageUrl");
        link = imageUrl;
      },
    );
    return link;
  }
}
