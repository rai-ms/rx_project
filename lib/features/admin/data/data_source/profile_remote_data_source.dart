import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/error/exceptions.dart';

import '../../domain/data_source/profile_remote_data_source.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  ProfileRemoteDataSourceImpl();

  @override
  Future<String> uploadProfilePicture(String localFilePath, String userId) async {
    try {
      final ref = _firebaseStorage.ref('profile_pictures/$userId.jpg');
      await ref.putFile(File(localFilePath));
      return await ref.getDownloadURL();
    } catch (e) {
      throw const ServerException('Failed to upload profile picture');
    }
  }

  @override
  Future<String> getProfilePictureUrl(String userId) async {
    try {
      final ref = _firebaseStorage.ref('profile_pictures/$userId.jpg');
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        throw const CacheException();
      }
      throw const ServerException('Failed to get profile picture URL');
    }
  }
}
