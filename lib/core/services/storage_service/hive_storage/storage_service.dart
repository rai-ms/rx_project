import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_project/core/base/base_service/base_service.dart'
    show BaseService;
import 'package:rx_project/core/services/storage_service/hive_storage/hive_constants.dart'
    show HiveBoxName;
import 'package:rx_project/core/utils/app_type_def.dart' show FVoid, FRVoid;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import '../../../base/logger/app_logger_impl.dart';
part 'item_storage_extension.dart';

/// [StorageService] is Use to manage all the Storage related works in the app
/// It uses [HiveBoxName] where box names are defined
/// It uses [HiveConstants], where keys are store for any particular value
@lazySingleton
class StorageService implements BaseService<FVoid, String> {
  /// Singleton [service] is a singleton of [StorageService]
  static final StorageService service = StorageService();

  /// [authBox] saves all the auth related data
  static Box? authBox;

  /// [coreBox] saves all the core related data
  static Box? coreBox;

  /// Use to save the directory [path]
  String? path;

  @override
  FVoid init({String? param}) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(dir.path);
      await _registerAdapters();
      await _openBoxes();
    } catch (e) {
      log.e("Error IN storage init $e");
    }
    log.d("Storage Service init");
  }

  FVoid _openBoxes() async {
    try {
      authBox = await Hive.openBox(HiveBoxName.authBox);
      coreBox = await Hive.openBox(HiveBoxName.appCoreBox);
    } catch (e) {
      log.e("Error while opening box $e");
    }
    log.d("All boxes opened");
  }

  dynamic getAuth({required String key}) {
    return authBox?.get(key);
  }

  FVoid setAuth({required String key, required value}) async {
    return await authBox
        ?.put(key, value)
        .then((onValue) {
          log.d("Data Saved to hive: $key");
        })
        .onError((error, s) {
          log.e("Error Saving Data to Auth [$key]: $s - $error");
        });
  }

  FVoid setCore({required dynamic value, required String key}) async {
    try {
      await coreBox?.put(key, value);
    } catch (e) {
      log.e("Error Saving data to Core BOx $value");
    }
  }

  dynamic getCore({required String key}) {
    return coreBox?.get(key);
  }

  Future<int> clearAuth() async {
    return await authBox?.clear() ?? -1;
  }

  Future<int> clearCore() async {
    return await coreBox?.clear() ?? -1;
  }

  FRVoid _registerAdapters() async {}
}
