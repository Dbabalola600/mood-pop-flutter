import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future readAValue(String key) async {
    String? value = await _storage.read(key: key);

    return value;
  }

  static Future deleteAValue(String key) async {
    await _storage.delete(key: key);
  }

  static Future deleteAllValues() async {
    var deleteData = await _storage.deleteAll();
    return deleteData;
  }

  static Future writeAValue(String key, String value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }
}
