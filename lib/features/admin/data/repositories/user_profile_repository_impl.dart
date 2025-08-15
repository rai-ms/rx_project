import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/data_source/user_profile_remote_data_source.dart';
import '../../domain/repository/user_profile_repository.dart';
import '../model/request/user_profile_model.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource _remoteDataSource;

  UserProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, UserProfileModel>> createUserProfile(UserProfileModel userProfile) async {
    return await _remoteDataSource.createUserProfile(userProfile);
  }

  @override
  Future<Either<Failure, void>> deleteUserProfile(String userId) async {
    return await _remoteDataSource.deleteUserProfile(userId);
  }

  @override
  Future<Either<Failure, List<UserProfileModel>>> getAllUserProfiles() async {
    return await _remoteDataSource.getAllUserProfiles();
  }

  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile(String userId) async {
    return await _remoteDataSource.getUserProfile(userId);
  }

  @override
  Future<Either<Failure, UserProfileModel>> updateUserProfile(UserProfileModel userProfile) async {
    return await _remoteDataSource.updateUserProfile(userProfile);
  }
}
