import 'package:injectable/injectable.dart';
import 'firebase_storage_service.dart';

@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseStorageService get firebaseStorageService => FirebaseStorageService();
  
  // Add any other Firebase service providers here
  // Example:
  // @lazySingleton
  // FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
