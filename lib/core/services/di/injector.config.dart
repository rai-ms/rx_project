// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../base/base_client/base_api_micro.dart' as _i609;
import '../../handler/state_request_handler.dart' as _i140;
import '../api_service/api_micro_dispatcher.dart' as _i778;
import '../api_service/api_small_dispatcher.dart' as _i892;
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
  gh.singleton<_i609.GetApiMicro<dynamic>>(() => _i609.GetApiMicro<dynamic>());
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
  gh.lazySingleton<_i140.StateRequestHandler>(
      () => _i140.StateRequestHandler());
  gh.lazySingleton<_i119.StorageService>(() => _i119.StorageService());
  gh.lazySingleton<_i892.SmallApiDispatcher>(() => _i892.SmallApiDispatcher());
  gh.lazySingleton<_i829.SecureStorageSource>(
      () => _i167.SecureStorageService());
  gh.lazySingleton<_i561.AuthStorageService>(
      () => _i561.AuthStorageServiceImpl(gh<_i829.SecureStorageSource>()));
  gh.lazySingleton<_i778.ApiDispatcher>(() => _i778.ApiDispatcher(
        gh<_i609.GetApiMicro<dynamic>>(),
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
  return getIt;
}
