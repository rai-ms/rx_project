import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/data_source/profile_remote_data_source.dart' show ProfileRemoteDataSource;
import '../../domain/repository/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  
  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> updateProfilePic(String imagePath) async {
    try {
      // In a real app, you would get the current user ID from your auth service
      const userId = 'current_user_id'; // Replace with actual user ID retrieval
      final imageUrl = await remoteDataSource.uploadProfilePicture(imagePath, userId);
      return Right(imageUrl);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException {
      return Left(CacheFailure('Failed to update profile picture'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getProfilePicUrl() async {
    try {
      const userId = 'current_user_id'; // Replace with actual user ID retrieval
      final imageUrl = await remoteDataSource.getProfilePictureUrl(userId);
      return Right(imageUrl);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException {
      return Left(CacheFailure('Profile picture not found'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
