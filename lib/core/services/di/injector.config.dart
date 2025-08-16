// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/admin/data/data_source/profile_remote_data_source.dart'
    as _i415;
import '../../../features/admin/data/data_source/project_remote_data_source_impl.dart'
    as _i274;
import '../../../features/admin/data/data_source/user_profile_remote_data_source_impl.dart'
    as _i78;
import '../../../features/admin/data/repositories/profile_repository_impl.dart'
    as _i816;
import '../../../features/admin/data/repositories/user_profile_repository_impl.dart'
    as _i647;
import '../../../features/admin/data/repository/project_repository_impl.dart'
    as _i365;
import '../../../features/admin/domain/data_source/profile_remote_data_source.dart'
    as _i592;
import '../../../features/admin/domain/data_source/project_remote_data_source.dart'
    as _i1065;
import '../../../features/admin/domain/data_source/user_profile_remote_data_source.dart'
    as _i885;
import '../../../features/admin/domain/repository/profile_repository.dart'
    as _i375;
import '../../../features/admin/domain/repository/project_repository.dart'
    as _i713;
import '../../../features/admin/domain/repository/user_profile_repository.dart'
    as _i258;
import '../../../features/admin/domain/use_case/profile_pic_use_case.dart'
    as _i510;
import '../../../features/admin/domain/use_case/project_use_cases.dart'
    as _i547;
import '../../../features/admin/domain/use_case/user_profile_use_cases.dart'
    as _i596;
import '../../../features/admin/presentation/manager/home_manage_bloc/home_manage_bloc.dart'
    as _i855;
import '../../../features/admin/presentation/manager/profile_manage_bloc/profile_manage_bloc.dart'
    as _i253;
import '../../../features/admin/presentation/manager/projects_bloc/projects_bloc.dart'
    as _i977;
import '../../base/base_client/base_api_micro.dart' as _i609;
import '../../handler/state_request_handler.dart' as _i140;
import '../api_service/api_micro_dispatcher.dart' as _i778;
import '../api_service/api_small_dispatcher.dart' as _i892;
import '../firebase_service/auth_service.dart' as _i872;
import '../language_service/language_service.dart' as _i908;
import '../permissin_service/permission_service.dart' as _i49;
import '../storage_service/auth_storage_service.dart' as _i561;
import '../storage_service/hive_storage/storage_service.dart' as _i119;
import '../storage_service/secure_storage/secure_storage_source.dart' as _i829;
import '../storage_service/secure_storage/secure_storage_source_impl.dart'
    as _i167;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt injectAllData(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i855.HomeManageBloc>(() => _i855.HomeManageBloc());
  gh.singleton<_i609.GetApiMicro>(() => _i609.GetApiMicro());
  gh.singleton<_i609.PostApiMicro>(() => _i609.PostApiMicro());
  gh.singleton<_i609.PatchApiMicro>(() => _i609.PatchApiMicro());
  gh.singleton<_i609.PutApiMicro>(() => _i609.PutApiMicro());
  gh.singleton<_i609.DeleteApiMicro>(() => _i609.DeleteApiMicro());
  gh.singleton<_i609.DownloadApiMicro>(() => _i609.DownloadApiMicro());
  gh.singleton<_i609.StreamApiMicro>(() => _i609.StreamApiMicro());
  gh.singleton<_i609.BytesApiMicro>(() => _i609.BytesApiMicro());
  gh.singleton<_i609.UploadApiMicro>(() => _i609.UploadApiMicro());
  gh.singleton<_i609.UploadStreamApiMicro>(() => _i609.UploadStreamApiMicro());
  gh.singleton<_i908.AppLanguageService>(() => _i908.AppLanguageService());
  gh.singleton<_i49.PermissionService>(() => _i49.PermissionService());
  gh.singleton<_i872.AuthService>(() => _i872.AuthService());
  gh.lazySingleton<_i140.StateRequestHandler>(
      () => _i140.StateRequestHandler());
  gh.lazySingleton<_i119.StorageService>(() => _i119.StorageService());
  gh.lazySingleton<_i892.SmallApiDispatcher>(() => _i892.SmallApiDispatcher());
  gh.lazySingleton<_i1065.ProjectRemoteDataSource>(
      () => _i274.ProjectRemoteDataSourceImpl());
  gh.lazySingleton<_i713.ProjectRepository>(() => _i365.ProjectRepositoryImpl(
      remoteDataSource: gh<_i1065.ProjectRemoteDataSource>()));
  gh.lazySingleton<_i778.ApiDispatcher>(() => _i778.ApiDispatcher(
        gh<_i609.GetApiMicro>(),
        gh<_i609.PostApiMicro>(),
        gh<_i609.PutApiMicro>(),
        gh<_i609.PatchApiMicro>(),
        gh<_i609.DeleteApiMicro>(),
        gh<_i609.DownloadApiMicro>(),
        gh<_i609.StreamApiMicro>(),
        gh<_i609.BytesApiMicro>(),
        gh<_i609.UploadApiMicro>(),
        gh<_i609.UploadStreamApiMicro>(),
      ));
  gh.lazySingleton<_i885.UserProfileRemoteDataSource>(
      () => _i78.UserProfileRemoteDataSourceImpl());
  gh.lazySingleton<_i592.ProfileRemoteDataSource>(
      () => _i415.ProfileRemoteDataSourceImpl());
  gh.lazySingleton<_i829.SecureStorageSource>(
      () => _i167.SecureStorageService());
  gh.lazySingleton<_i375.ProfileRepository>(
      () => _i816.ProfileRepositoryImpl(gh<_i592.ProfileRemoteDataSource>()));
  gh.lazySingleton<_i561.AuthStorageService>(
      () => _i561.AuthStorageServiceImpl(gh<_i829.SecureStorageSource>()));
  gh.factory<_i510.UpdateProfilePicUseCase>(
      () => _i510.UpdateProfilePicUseCase(gh<_i375.ProfileRepository>()));
  gh.factory<_i510.GetProfilePicUrlUseCase>(
      () => _i510.GetProfilePicUrlUseCase(gh<_i375.ProfileRepository>()));
  gh.lazySingleton<_i258.UserProfileRepository>(() =>
      _i647.UserProfileRepositoryImpl(gh<_i885.UserProfileRemoteDataSource>()));
  gh.factory<_i547.GetProjectsUseCase>(
      () => _i547.GetProjectsUseCase(gh<_i713.ProjectRepository>()));
  gh.factory<_i547.CreateProjectUseCase>(
      () => _i547.CreateProjectUseCase(gh<_i713.ProjectRepository>()));
  gh.factory<_i547.UpdateProjectUseCase>(
      () => _i547.UpdateProjectUseCase(gh<_i713.ProjectRepository>()));
  gh.factory<_i547.DeleteProjectUseCase>(
      () => _i547.DeleteProjectUseCase(gh<_i713.ProjectRepository>()));
  gh.factory<_i547.UploadProjectImageUseCase>(
      () => _i547.UploadProjectImageUseCase(gh<_i713.ProjectRepository>()));
  gh.factory<_i596.CreateUserProfileUseCase>(
      () => _i596.CreateUserProfileUseCase(gh<_i258.UserProfileRepository>()));
  gh.factory<_i596.GetUserProfileUseCase>(
      () => _i596.GetUserProfileUseCase(gh<_i258.UserProfileRepository>()));
  gh.factory<_i596.GetAllUserProfilesUseCase>(
      () => _i596.GetAllUserProfilesUseCase(gh<_i258.UserProfileRepository>()));
  gh.factory<_i596.UpdateUserProfileUseCase>(
      () => _i596.UpdateUserProfileUseCase(gh<_i258.UserProfileRepository>()));
  gh.factory<_i596.DeleteUserProfileUseCase>(
      () => _i596.DeleteUserProfileUseCase(gh<_i258.UserProfileRepository>()));
  gh.factory<_i977.ProjectsBloc>(() => _i977.ProjectsBloc(
        gh<_i547.CreateProjectUseCase>(),
        gh<_i547.GetProjectsUseCase>(),
        gh<_i547.UpdateProjectUseCase>(),
        gh<_i547.DeleteProjectUseCase>(),
        gh<_i547.UploadProjectImageUseCase>(),
      ));
  gh.factory<_i253.ProfileManageBloc>(() => _i253.ProfileManageBloc(
        gh<_i596.CreateUserProfileUseCase>(),
        gh<_i596.DeleteUserProfileUseCase>(),
        gh<_i596.GetAllUserProfilesUseCase>(),
        gh<_i596.GetUserProfileUseCase>(),
        gh<_i596.UpdateUserProfileUseCase>(),
      ));
  return getIt;
}
