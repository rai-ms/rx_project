import 'package:rx_project/features/resume/domain/models/resume_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get resume data
  Future<ResumeDataModel> getResumeData() async {
    try {
      final doc = await _firestore.collection('admin').doc('links').get();
      if (doc.exists) {
        return ResumeDataModel.fromMap(doc.data()!);
      }
      return const ResumeDataModel();
    } catch (e) {
      throw Exception('Failed to get resume data: $e');
    }
  }

  // Update resume data
  Future<void> updateResumeData({
    required String resumeUrl,
    bool showResumeViaLink = false,
  }) async {
    try {
      await _firestore.collection('admin').doc('links').set(
        {
          'resumeUrl': resumeUrl,
          'showResumeViaLink': showResumeViaLink,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      throw Exception('Failed to update resume data: $e');
    }
  }
}
