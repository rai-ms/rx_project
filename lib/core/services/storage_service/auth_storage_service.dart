import 'package:injectable/injectable.dart';
import 'secure_storage/secure_storage_keys.dart';
import 'secure_storage/secure_storage_source.dart';

abstract class AuthStorageService {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String token);
  Future<void> saveIntroCompleted(bool isCompleted);
  Future<void> clearAccessToken();
  Future<void> clearAuthData();
  Future<bool> hasAccessToken();
  Future<bool> hasIntroCompleted();
}

@LazySingleton(as: AuthStorageService)
class AuthStorageServiceImpl implements AuthStorageService {
  final SecureStorageSource _secureStorage;

  @factoryMethod
  AuthStorageServiceImpl(this._secureStorage);

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(SecureStorageKeys.kAccessToken);
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(SecureStorageKeys.kAccessToken, token);
  }

  @override
  Future<void> clearAccessToken() async {
    await _secureStorage.delete(SecureStorageKeys.kAccessToken);
  }

  @override
  Future<bool> hasAccessToken() async {
    return await _secureStorage.containsKey(SecureStorageKeys.kAccessToken);
  }

  @override
  Future<bool> hasIntroCompleted() async {
    return await _secureStorage.containsKey(SecureStorageKeys.isIntroCompleted);
  }


  @override
  Future<void> saveIntroCompleted(bool isCompleted) async {
    await _secureStorage.write(SecureStorageKeys.isIntroCompleted, isCompleted.toString());
  }

  @override
  Future<void> clearAuthData() async {
    await clearAccessToken();
  }


}
