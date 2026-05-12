import "package:flutter/material.dart";

import "theme.dart";
import "screens/home_screen.dart";
import "screens/login_screen.dart";
import "screens/profile_screen.dart";
import "screens/settings_screen.dart";
import "config.dart";
import "utils/http_client.dart";
import "services/storage_service.dart";

void main() async {
  HttpClient().initialize(baseUrl: AppConfig.API_BASE_URL);
  String? token = await StorageService.getToken();
  if (token != null && token.isNotEmpty) {
    HttpClient().addHeader("Authorization", "Bearer $token");
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo App 101",
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      initialRoute: "/login",
      routes: {
        "/": (context) => HomeScreen(isDarkMode: _isDarkMode, onToggleTheme: _toggleTheme),
        "/login": (context) => LoginScreen(isDarkMode: _isDarkMode, onToggleTheme: _toggleTheme),
        "/profile": (context) => ProfileScreen(isDarkMode: _isDarkMode, onToggleTheme: _toggleTheme),
        "/settings": (context) => SettingsScreen(isDarkMode: _isDarkMode, onToggleTheme: _toggleTheme),
      },
    );
  }
}
