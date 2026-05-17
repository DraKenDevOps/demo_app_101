import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "theme.dart";
import "config.dart";
import "utils/http_client.dart";
import "services/storage_service.dart";
import "routes.dart";

void main() async {
  await dotenv.load(fileName: ".env");
  
  HttpClient http = HttpClient();
  http.initialize(baseUrl: AppConfig.API_BASE_URL_V1);
  String? token = await StorageService.getToken();
  if (token != null && token.isNotEmpty) http.addHeader("Authorization", "Bearer $token");
  AppConfig.printAllEnv();
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
      title: AppConfig.APP_NAME,
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