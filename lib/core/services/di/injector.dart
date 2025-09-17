import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/base/base_service/base_service.dart'
    show BaseService;
import 'package:rx_project/core/services/firebase_service/firebase_module.dart';
import 'package:rx_project/core/utils/app_type_def.dart' show FVoid;
import 'package:rx_project/features/resume/di/resume_module.dart';
import 'injector.config.dart';

// fvm dart run build_runner build --delete-conflicting-outputs

final GetIt _inject = GetIt.instance;

@InjectableInit(
  initializerName: 'injectAllData',
  preferRelativeImports: true,
  asExtension: false,
  includeMicroPackages: true,
)
void _configureInjection() {
  // Register modules
  _inject.registerLazySingleton<FirebaseModule>(() => throw UnimplementedError());
  _inject.registerLazySingleton<ResumeModule>(() => throw UnimplementedError());
  
  // Initialize injectable
  injectAllData(_inject);
}

class InjectorService extends BaseService<FVoid, void> {
  static final InjectorService service = InjectorService._();

  InjectorService._();

  GetIt get inject => _inject;

  @override
  FVoid init({void param}) async {
    _configureInjection();
  }
}
