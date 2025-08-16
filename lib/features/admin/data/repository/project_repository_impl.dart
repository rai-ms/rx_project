import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart' show LazySingleton;
import 'package:rx_project/core/error/failures.dart';
import 'package:rx_project/features/admin/domain/data_source/project_remote_data_source.dart';
import 'package:rx_project/features/admin/domain/model/request/home_project_model.dart';
import 'package:rx_project/features/admin/domain/repository/project_repository.dart';

@LazySingleton(as: ProjectRepository)
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HomeProjectModel>>> getProjects() async {
    return await remoteDataSource.getProjects();
  }

  @override
  Future<Either<Failure, HomeProjectModel>> createProject(
      HomeProjectModel project) async {
    return await remoteDataSource.createProject(project);
  }

  @override
  Future<Either<Failure, HomeProjectModel>> updateProject(
      HomeProjectModel project) async {
    return await remoteDataSource.updateProject(project);
  }

  @override
  Future<Either<Failure, void>> deleteProject(String projectId) async {
    return await remoteDataSource.deleteProject(projectId);
  }

  @override
  Future<Either<Failure, String>> uploadProjectImage({
    required dynamic file,
    String? projectId,
  }) async {
    return await remoteDataSource.uploadProjectImage(
      file: file,
      projectId: projectId,
    );
  }
}
