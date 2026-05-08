// import "dart:convert";
// import "dart:nativewrappers/_internal/vm/lib/developer.dart";

import "dart:convert";

import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:flutter/foundation.dart";

class StorageService {
  static const _secureStorage = FlutterSecureStorage();

  static const String _tokenKey = "jwt_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _userKey = "user_data";

  static Future<void> saveData(String key, dynamic data) async {
    try {
      String value = "";
      if (data is! String) value = data.toString();
      if (data is Object) value = json.encode(data);
      await _secureStorage.write(key: key, value: value);
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

  static Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error saving token: $e");
    }
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error saving refresh token: $e");
    }
  }

  static Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: _tokenKey);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error reading token: $e");
      return null;
    }
  }

  static Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _refreshTokenKey);
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
      await _secureStorage.delete(key: _tokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await _secureStorage.delete(key: _userKey);
    } catch (e) {
      if (kDebugMode) debugPrint("✗ Error deleting token(s): $e");
      // log(e.toString());
    }
  }
}
