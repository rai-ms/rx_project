import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_use_case/no_params.dart' show NoParams;
import '../../../../core/base/base_use_case/use_case.dart';
import '../../../../core/error/failures.dart';
import '../repository/user_profile_repository.dart';
import '../../data/model/request/user_profile_model.dart';

@injectable
class CreateUserProfileUseCase extends UseCase<Either<Failure, UserProfileModel>, UserProfileModel> {
  final UserProfileRepository _repository;

  CreateUserProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UserProfileModel>> call({required UserProfileModel params}) async {
    return await _repository.createUserProfile(params);
  }
}

@injectable
class GetUserProfileUseCase extends UseCase<Either<Failure, UserProfileModel>, String> {
  final UserProfileRepository _repository;

  GetUserProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UserProfileModel>> call({required String params}) async {
    return await _repository.getUserProfile(params);
  }
}

@injectable
class GetAllUserProfilesUseCase extends UseCase<Either<Failure, List<UserProfileModel>>, NoParams> {
  final UserProfileRepository _repository;

  GetAllUserProfilesUseCase(this._repository);

  @override
  Future<Either<Failure, List<UserProfileModel>>> call({required NoParams params}) async {
    return await _repository.getAllUserProfiles();
  }
}

@injectable
class UpdateUserProfileUseCase extends UseCase<Either<Failure, UserProfileModel>, UserProfileModel> {
  final UserProfileRepository _repository;

  UpdateUserProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UserProfileModel>> call({required UserProfileModel params}) async {
    return await _repository.updateUserProfile(params);
  }
}

@injectable
class DeleteUserProfileUseCase extends UseCase<Either<Failure, void>, String> {
  final UserProfileRepository _repository;

  DeleteUserProfileUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call({required String params}) async {
    return await _repository.deleteUserProfile(params);
  }
}
