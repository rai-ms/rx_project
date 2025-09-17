import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/base/logger/app_logger_impl.dart';
import 'package:rx_project/core/services/firebase_service/firebase_storage_service.dart';
import 'package:rx_project/features/resume/domain/models/resume_data_model.dart';
import 'package:rx_project/features/resume/domain/repository/resume_repository.dart';

@injectable
class ResumeRepositoryImpl implements ResumeRepository {
  final FirebaseStorageService _storageService;
  final FirebaseFirestore _firestore;

  static const String _collectionPath = 'admin';
  static const String _documentId = 'links';

  ResumeRepositoryImpl(this._storageService)
    : _firestore = FirebaseFirestore.instance;

  @override
  Future<ResumeDataModel> getResumeData() async {
    try {
      final doc = await _firestore
          .collection(_collectionPath)
          .doc(_documentId)
          .get();

      Log.d("Received data of resume is ${doc.data()}");

      if (!doc.exists) {
        return const ResumeDataModel(resumeUrl: '');
      }

      return ResumeDataModel.fromMap(doc.data() ?? {});
    } catch (e) {
      throw Exception('Failed to fetch resume data: $e');
    }
  }

  @override
  Future<void> updateResumeData(ResumeDataModel resumeData) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(_documentId)
          .set(resumeData.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update resume data: $e');
    }
  }

  @override
  Future<String> uploadResume(File file) async {
    try {
      final fileName = 'resume_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final fileUrl = await _storageService.uploadFile(
        file: file,
        path: 'resumes',
        fileName: fileName,
      );

      // Update the resume URL in Firestore
      await updateResumeData(ResumeDataModel(resumeUrl: fileUrl));

      return fileUrl;
    } catch (e) {
      throw Exception('Failed to upload resume: $e');
    }
  }

  @override
  Future<String> uploadProfileImage(File file) async {
    try {
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final fileUrl = await _storageService.uploadFile(
        file: file,
        path: 'profile_images',
        fileName: fileName,
      );

      // Update the profile image URL in Firestore
      final currentData = await getResumeData();
      await updateResumeData(currentData.copyWith(profileImageUrl: fileUrl));

      return fileUrl;
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }
}
