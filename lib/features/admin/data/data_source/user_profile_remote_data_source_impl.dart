import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/features/admin/domain/data_source/user_profile_remote_data_source.dart';
import 'package:rx_project/features/admin/data/model/request/user_profile_model.dart';
import '../../../../core/error/failures.dart' show Failure, ServerFailure, NotFoundFailure;

@LazySingleton(as: UserProfileRemoteDataSource)
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'user_profiles';

  UserProfileRemoteDataSourceImpl();

  @override
  Future<Either<Failure, UserProfileModel>> createUserProfile(
      UserProfileModel userProfile) async {
    try {
      await _firestore
          .collection(_collection)
          .doc("1025980200000")
          .set(userProfile.toJson(), SetOptions(merge: true));
      return Right(userProfile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();

      if (!doc.exists || doc.data() == null) {
        return Left(NotFoundFailure('User profile not found'));
      }

      final data = doc.data()!;
      return Right(UserProfileModel.fromJson({
        ...data,
        'id': doc.id,
      }));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserProfileModel>>> getAllUserProfiles() async {
    try {
      final querySnapshot = await _firestore.collection(_collection).get();
      final profiles = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return UserProfileModel.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();

      return Right(profiles);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> updateUserProfile(
      UserProfileModel userProfile) async {
    try {
      await _firestore
          .collection(_collection)
          .doc("1025980200000")
          .update(userProfile.toJson());
      return Right(userProfile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserProfile(String userId) async {
    try {
      await _firestore.collection(_collection).doc(userId).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
