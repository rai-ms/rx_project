import 'package:dartz/dartz.dart';
import 'package:rx_project/core/error/failures.dart';
import 'package:rx_project/features/admin/data/model/request/user_profile_model.dart';

abstract class UserProfileRepository {
  // Create
  Future<Either<Failure, UserProfileModel>> createUserProfile(UserProfileModel userProfile);
  
  // Read
  Future<Either<Failure, UserProfileModel>> getUserProfile(String userId);
  Future<Either<Failure, List<UserProfileModel>>> getAllUserProfiles();
  
  // Update
  Future<Either<Failure, UserProfileModel>> updateUserProfile(UserProfileModel userProfile);
  
  // Delete
  Future<Either<Failure, void>> deleteUserProfile(String userId);
}
