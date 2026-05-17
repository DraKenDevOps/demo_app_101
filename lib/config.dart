import "package:flutter/foundation.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

class AppConfig {
  static String get APP_NAME => dotenv.env["APP_NAME"] ?? "Demo App 101";
  static String get BASE_URL => dotenv.env["BASE_URL"] ?? "http://localhost:8000";
  static String get API_BASE_PATH => dotenv.env["API_BASE_PATH"] ?? "api";
  static String get API_BASE_URL_V1 => "$BASE_URL/$API_BASE_PATH/v1";
  static String get API_BASE_URL_V2 => "$BASE_URL/$API_BASE_PATH/v2";
  static String get ACCESS_TOKEN_KEY => dotenv.env["ACCESS_TOKEN_KEY"] ?? "access_token";
  static String get REFRESH_TOKEN_KEY => dotenv.env["REFRESH_TOKEN_KEY"] ?? "refresh_token";
  static String get USER_KEY => dotenv.env["USER_KEY"] ?? "user_data";
  static String get APP_THEME_KEY => dotenv.env["APP_THEME_KEY"] ?? "app_theme";
  static String get API_KEY => dotenv.env["API_KEY"] ?? "default_key";
  static String get FIREBASE_PROJECT_ID => dotenv.env["FIREBASE_PROJECT_ID"] ?? "";
  static bool get ENABLE_LOGGING => dotenv.env["ENABLE_LOGGING"]?.toLowerCase() == "true";
  static int get REQUEST_TIMEOUT => int.tryParse(dotenv.env["REQUEST_TIMEOUT"] ?? "10") ?? 10;

  static String get MODE {
    if (BASE_URL.contains("localhost")) return "development";
    if (BASE_URL.contains("staging")) return "staging";
    return "production";
  }

  static void printAllEnv() {
    if (kDebugMode) {
      print("=== Environment Config ===");
      print("API Base URL: $API_BASE_URL_V1");
      print("API Base URL: $API_BASE_URL_V2");
      print("API Key: ${API_KEY.substring(0, 3)}***");
      print("Firebase Project: $FIREBASE_PROJECT_ID");
      print("Logging Enabled: $ENABLE_LOGGING");
      print("Request Timeout: $REQUEST_TIMEOUT seconds");
      print("========================");
    }
  }
}

class EnvConfig {
  static String get APP_NAME => String.fromEnvironment("APP_NAME", defaultValue: "Demo App 101");
  static String get BASE_URL => String.fromEnvironment("BASE_URL", defaultValue: "http://localhost:8000");
  static String get API_BASE_PATH => String.fromEnvironment("API_BASE_PATH", defaultValue: "api");
  static String get API_BASE_URL_V1 => "$BASE_URL/$API_BASE_PATH/v1";
  static String get API_BASE_URL_V2 => "$BASE_URL/$API_BASE_PATH/v2";

  static String get ACCESS_TOKEN_KEY => String.fromEnvironment("ACCESS_TOKEN_KEY", defaultValue: "access_token");
  static String get REFRESH_TOKEN_KEY => String.fromEnvironment("REFRESH_TOKEN_KEY", defaultValue: "refresh_token");
  static String get USER_KEY => String.fromEnvironment("USER_KEY", defaultValue: "user_data");
  static String get APP_THEME_KEY => String.fromEnvironment("APP_THEME_KEY", defaultValue: "app_theme");

  static String API_KEY = String.fromEnvironment("API_KEY", defaultValue: "");
  static String get FIREBASE_PROJECT_ID => String.fromEnvironment("FIREBASE_PROJECT_ID", defaultValue: "");
  static bool get ENABLE_LOGGING => String.fromEnvironment("ENABLE_LOGGING").toLowerCase() == "true";
  static int? REQUEST_TIMEOUT = int.tryParse(String.fromEnvironment("REQUEST_TIMEOUT", defaultValue: "10"));

  static String get MODE {
    if (BASE_URL.contains("localhost")) return "development";
    if (BASE_URL.contains("staging")) return "staging";
    return "production";
  }

  static void printAllEnv() {
    if (kDebugMode) {
      print("=== Environment Config ===");
      print("API Base URL: $API_BASE_URL_V1");
      print("API Base URL: $API_BASE_URL_V2");
      print("API Key: ${API_KEY.substring(0, 3)}***");
      print("Firebase Project: $FIREBASE_PROJECT_ID");
      print("Logging Enabled: $ENABLE_LOGGING");
      print("Request Timeout: $REQUEST_TIMEOUT seconds");
      print("========================");
    }
  }
}
