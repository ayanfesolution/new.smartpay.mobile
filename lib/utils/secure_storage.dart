

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage(this.storage);
  FlutterSecureStorage storage;

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    final readData = await storage.read(key: key);
    return readData;
  }

  Future<void> deleteSecureData() async {
    await storage.deleteAll();
  }
}