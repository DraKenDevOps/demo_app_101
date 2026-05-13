import "package:flutter/material.dart";

import "screens/login_screen.dart";
import "layouts/main_layout.dart";
import "guards/login_guard.dart";
import "guards/auth_guard.dart";

class AppRoutes {
  static const String home = "/";
  static const String login = "/login";

  static Map<String, Widget Function(BuildContext)> getRoutes({
    required bool isDarkMode,
    required VoidCallback onToggleTheme,
  }) {
    return {
      home: (context) => AuthGuard(
        child: MainLayout(isDarkMode: isDarkMode, onToggleTheme: onToggleTheme),
      ),
      login: (context) => LoginGuard(
        child: LoginScreen(isDarkMode: isDarkMode, onToggleTheme: onToggleTheme),
      ),
    };
  }
}
