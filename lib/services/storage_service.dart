import "dart:convert";
import "package:flutter/foundation.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "../config.dart";

class StorageService {
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> saveData(String key, dynamic data) async {
    try {
      String value = "";
      if (data is! String) value = data.toString();
      if (data is Object) value = json.encode(data);
      await _secureStorage.write(key: key, value: value);
      viewStorage();
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error saving $key: $e");
    }
  }

  static Future<String?> getData(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error get $key: $e");
      return null;
    }
  }

  static Future<void> deleteData(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error deleting $key: $e");
    }
  }

  static Future<void> clearData() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error secure storage clear all: $e");
    }
  }

  static Future<void> saveAccessToken(String token) async {
    try {
      await _secureStorage.write(key: AppConfig.ACCESS_TOKEN_KEY, value: token);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error saving token: $e");
    }
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _secureStorage.write(key: AppConfig.REFRESH_TOKEN_KEY, value: refreshToken);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error saving refresh token: $e");
    }
  }

  static Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: AppConfig.ACCESS_TOKEN_KEY);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error reading token: $e");
      return null;
    }
  }

  static Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: AppConfig.REFRESH_TOKEN_KEY);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error reading refresh token: $e");
      return null;
    }
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> deleteToken() async {
    try {
      await _secureStorage.delete(key: AppConfig.ACCESS_TOKEN_KEY);
      await _secureStorage.delete(key: AppConfig.REFRESH_TOKEN_KEY);
      await _secureStorage.delete(key: AppConfig.USER_KEY);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error deleting token(s): $e");
      // log(e.toString());
    }
  }

  static Future<Map<String, String>> getAllData() async {
    try {
      return await _secureStorage.readAll();
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error get all data: $e");
      return {};
    }
  }

  static void viewStorage() {
    if (kDebugMode) {
      StorageService.getAllData().then((values) {
        values.forEach((key, value) {
          debugPrint("Key: $key, Value: $value");
        });
      });
    }
  }
}
