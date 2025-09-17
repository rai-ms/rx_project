import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rx_project/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    final firestore = FirebaseFirestore.instance;
    
    // Create or update the document
    await firestore.collection('admin').doc('links').set({
      'resumeUrl': '',  // This will be updated when you upload a resume
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    print('Successfully initialized Firestore document at admin/links');
    print('Document path: admin/links');
    print('You can now upload a resume using the app.');
  } catch (e) {
    print('Error initializing Firestore: $e');
  }
}
