import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/base/base_use_case/no_params.dart' show NoParams;
import 'package:rx_project/core/base/base_use_case/use_case.dart';
import '../../../../core/error/failures.dart';
import '../../data/model/request/update_profile_pic_param.dart';
import '../repository/profile_repository.dart';

@injectable
class UpdateProfilePicUseCase extends UseCase<Either<Failure, String>, UpdateProfilePicParams> {
  final ProfileRepository _repository;

  UpdateProfilePicUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call({required UpdateProfilePicParams params}) async {
    return await _repository.updateProfilePic(params.imagePath);
  }
}

@injectable
class GetProfilePicUrlUseCase extends UseCase<Either<Failure, String>, NoParams> {
  final ProfileRepository _repository;

  GetProfilePicUrlUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call({required NoParams params}) async {
    return await _repository.getProfilePicUrl();
  }
}
