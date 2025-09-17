import 'dart:io';

import '../models/resume_data_model.dart';

abstract class ResumeRepository {
  /// Fetches the resume data from Firestore
  Future<ResumeDataModel> getResumeData();
  
  /// Updates the resume data in Firestore
  Future<void> updateResumeData(ResumeDataModel resumeData);
  
  /// Uploads a new resume file to storage and updates the URL
  Future<String> uploadResume(File file);
  
  /// Uploads a new profile image to storage and updates the URL
  Future<String> uploadProfileImage(File file);
}
