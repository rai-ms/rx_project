import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart' show LazySingleton;
import 'package:rx_project/core/error/failures.dart';
import 'package:rx_project/features/admin/domain/model/request/home_project_model.dart';
import '../../domain/data_source/project_remote_data_source.dart' show ProjectRemoteDataSource;

@LazySingleton(as: ProjectRemoteDataSource)
class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final String collectionName = 'projects';

  ProjectRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<HomeProjectModel>>> getProjects() async {
    try {
      final snapshot = await firestore.collection(collectionName).get();
      final projects = snapshot.docs
          .map((doc) => HomeProjectModel.fromJson(doc.data()..['id'] = doc.id))
          .toList();
      return Right(projects);
    } on FirebaseException catch (e) {
      return Left(ServerFailure( e.message ?? 'Failed to fetch projects'));
    } catch (e) {
      return Left(ServerFailure( 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, HomeProjectModel>> createProject(HomeProjectModel project) async {
    try {
      final docRef = await firestore.collection(collectionName).add(project.toJson());
      final createdProject = project.copyWith(id: docRef.id);
      return Right(createdProject);
    } on FirebaseException catch (e) {
      return Left(ServerFailure( e.message ?? 'Failed to create project'));
    } catch (e) {
      return Left(ServerFailure( 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, HomeProjectModel>> updateProject(HomeProjectModel project) async {
    try {
      await firestore
          .collection(collectionName)
          .doc(project.id)
          .update(project.toJson()..remove('id'));
      return Right(project);
    } on FirebaseException catch (e) {
      return Left(ServerFailure( e.message ?? 'Failed to update project'));
    } catch (e) {
      return Left(ServerFailure( 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String projectId) async {
    try {
      await firestore.collection(collectionName).doc(projectId).delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure( e.message ?? 'Failed to delete project'));
    } catch (e) {
      return Left(ServerFailure( 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProjectImage({
    required XFile file,
    String? projectId,
  }) async {
    try {
      final XFile imageFile = file;
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}';
      final String path = 'projects/${projectId ?? 'temp'}/$fileName';
      
      final ref = storage.ref().child(path);
      final uploadTask = ref.putFile(File(imageFile.path));
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return Right(downloadUrl);
    } on FirebaseException catch (e) {
      return Left(ServerFailure( e.message ?? 'Failed to upload image'));
    } catch (e) {
      return Left(ServerFailure( 'Failed to process image'));
    }
  }
}
