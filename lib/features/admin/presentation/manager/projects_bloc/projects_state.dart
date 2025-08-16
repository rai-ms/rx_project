part of 'projects_bloc.dart';

class ProjectsState extends BlocEventState<List<HomeProjectModel>> {
  final String? selectedImageUrl;
  final bool isUploadingImage;

  const ProjectsState({
    this.selectedImageUrl,
    this.isUploadingImage = false,
    super.data,
    super.error,
    super.event,
    super.state,
    super.statusCode
  });

  @override
  ProjectsState copyWith({
    List<HomeProjectModel>? data,
    String? error,
    BlocEvent? event,
    int? statusCode,
    String? selectedImageUrl,
    bool? isUploadingImage,
    BlocState? state,
  }) {
    return ProjectsState(
      data: data ?? this.data,
      error: error ?? this.error,
      event: event ?? this.event,
      state: state ?? this.state,
      statusCode: statusCode ?? this.statusCode,
      selectedImageUrl: selectedImageUrl ?? this.selectedImageUrl,
      isUploadingImage: isUploadingImage ?? this.isUploadingImage,
    );
  }

  @override
  ProjectsState clear() => ProjectsState();
}
