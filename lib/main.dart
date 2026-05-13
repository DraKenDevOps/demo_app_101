import "package:flutter/material.dart";

import "theme.dart";
import "config.dart";
import "utils/http_client.dart";
import "services/storage_service.dart";
import "routes.dart";

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

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await StorageService.getData(AppConfig.APP_THEME_KEY);
    if (mounted) {
      setState(() {
        _isDarkMode = theme == "dark";
      });
    }
  }

  void _toggleTheme() {
    StorageService.saveData(AppConfig.APP_THEME_KEY, _isDarkMode ? "dark" : "light");
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
      initialRoute: AppRoutes.login,
      routes: AppRoutes.getRoutes(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}