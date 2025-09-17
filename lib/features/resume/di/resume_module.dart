import 'package:injectable/injectable.dart';
import 'package:rx_project/core/services/firebase_service/firebase_storage_service.dart';
import 'package:rx_project/features/resume/data/repository/resume_repository_impl.dart';
import 'package:rx_project/features/resume/domain/repository/resume_repository.dart';

@module
abstract class ResumeModule {
  @lazySingleton
  ResumeRepository provideResumeRepository(FirebaseStorageService storageService) {
    return ResumeRepositoryImpl(storageService);
  }
  }
