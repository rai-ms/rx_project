import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rx_project/core/error/failures.dart';
import 'package:rx_project/features/admin/domain/model/request/home_project_model.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<HomeProjectModel>>> getProjects();
  Future<Either<Failure, HomeProjectModel>> createProject(HomeProjectModel project);
  Future<Either<Failure, HomeProjectModel>> updateProject(HomeProjectModel project);
  Future<Either<Failure, void>> deleteProject(String projectId);
  Future<Either<Failure, String>> uploadProjectImage({
    required XFile file,
    String? projectId,
  });
}
