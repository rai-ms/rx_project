import 'package:dartz/dartz.dart';
import 'package:rx_project/core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> updateProfilePic(String imagePath);
  Future<Either<Failure, String>> getProfilePicUrl();
}
