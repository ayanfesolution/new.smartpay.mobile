import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smartpay_mobile/utils/secure_storage.dart';

import '../api/api_client.dart';
import '../server_interactions/datasource/auth_source.dart';
import '../server_interactions/repository/auth_repository.dart';
import 'constants.dart';

final GetIt getIt = GetIt.instance;

class Helper {
  static Future<String?> get token async {
    final storage = getIt.get<SecureStorage>();
    final token = await storage.readSecureData(kUserToken);
    if (token != null) return token;
    return null;
  }

  static void clearStorage() async {
    final storage = getIt.get<SecureStorage>();
    storage.deleteSecureData();
  }

  static Future<String> get deviveName async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.device;
  }
}

Future<void> initializeDependencies() async {
  getIt
    ..registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new)
    ..registerLazySingleton<SecureStorage>(() => SecureStorage(getIt()))
    //auth
    ..registerLazySingleton<ApiClient>(() => ApiClient(getIt()))
    ..registerLazySingleton<Dio>(Dio.new)
    //auth
    ..registerLazySingleton<AuthDataSource>(() => AuthDataSource(getIt()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepository(getIt(), getIt()),
    );
}
