import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/error/failures.dart';
import 'package:rx_project/features/admin/domain/model/request/home_project_model.dart';
import 'package:rx_project/features/admin/domain/repository/project_repository.dart';

import '../../../../core/base/base_use_case/no_params.dart';
import '../../../../core/base/base_use_case/use_case.dart';

@injectable
class GetProjectsUseCase
    extends UseCase<Either<Failure, List<HomeProjectModel>>, NoParams> {
  final ProjectRepository repository;

  GetProjectsUseCase(this.repository);

  @override
  Future<Either<Failure, List<HomeProjectModel>>> call({required NoParams params}) async {
    return await repository.getProjects();
  }
}

@injectable
class CreateProjectUseCase
    extends UseCase<Either<Failure, HomeProjectModel>, HomeProjectModel> {
  final ProjectRepository repository;

  CreateProjectUseCase(this.repository);

  @override
  Future<Either<Failure, HomeProjectModel>> call({required HomeProjectModel params}) async {
    return await repository.createProject(params);
  }
}

@injectable
class UpdateProjectUseCase
    extends UseCase<Either<Failure, HomeProjectModel>, HomeProjectModel> {
  final ProjectRepository repository;

  UpdateProjectUseCase(this.repository);

  @override
  Future<Either<Failure, HomeProjectModel>> call({required HomeProjectModel params}) async {
    return await repository.updateProject(params);
  }
}

@injectable
class DeleteProjectUseCase extends UseCase<void, String> {
  final ProjectRepository repository;

  DeleteProjectUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call({required String params}) async {
    return await repository.deleteProject(params);
  }
}

class UploadImageParams {
  final dynamic file;
  final String? projectId;

  UploadImageParams({required this.file, this.projectId});
}

@injectable
class UploadProjectImageUseCase
    extends UseCase<Either<Failure, String>, UploadImageParams> {
  final ProjectRepository repository;

  UploadProjectImageUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call({required
  UploadImageParams params}) async {
    return await repository.uploadProjectImage(
      file: params.file,
      projectId: params.projectId,
    );
  }
}
