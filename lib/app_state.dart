import "package:flutter/material.dart";

import "config.dart";
import "services/auth_service.dart";
import "services/storage_service.dart";

class AppState extends ChangeNotifier {
  AppState._();

  static final AppState instance = AppState._();

  bool isDarkMode = false;
  bool isAuthenticated = false;

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> loadTheme() async {
    final theme = await StorageService.getData(AppConfig.APP_THEME_KEY);
    isDarkMode = theme == "dark";
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    StorageService.saveData(AppConfig.APP_THEME_KEY, isDarkMode ? "dark" : "light");
    notifyListeners();
  }

  void login() {
    isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    AuthService().logout();
    isAuthenticated = false;
    notifyListeners();
  }
}
