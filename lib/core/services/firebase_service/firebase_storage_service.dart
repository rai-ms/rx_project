import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a file to Firebase Storage
  Future<String> uploadFile({
    required File file,
    required String path,
    String? fileName,
  }) async {
    try {
      final ref = _storage.ref('$path/${fileName ?? DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  // Get download URL for a file
  Future<String> getDownloadUrl(String filePath) async {
    try {
      final ref = _storage.ref(filePath);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to get download URL: $e');
    }
  }

  // Delete a file from Firebase Storage
  Future<void> deleteFile(String fileUrl) async {
    try {
      final ref = _storage.refFromURL(fileUrl);
      await ref.delete();
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  // List all files in a path
  Future<List<String>> listFiles(String path) async {
    try {
      final ref = _storage.ref(path);
      final result = await ref.listAll();
      final urls = await Future.wait(
        result.items.map((item) => item.getDownloadURL()).toList(),
      );
      return urls;
    } catch (e) {
      throw Exception('Failed to list files: $e');
    }
  }
}
