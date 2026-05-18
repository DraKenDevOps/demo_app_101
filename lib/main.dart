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
  http.initialize(baseUrl: AppConfig.API_BASE_URL_V2);
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
  ThemeMode _themeMode = ThemeMode.light;

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
        _themeMode = theme == "dark" ? ThemeMode.dark : ThemeMode.light;
      });
    }
  }

  void _toggleTheme() {
    StorageService.saveData(AppConfig.APP_THEME_KEY, _isDarkMode ? "dark" : "light");
    setState(() {
      _isDarkMode = !_isDarkMode;
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.APP_NAME,
      debugShowCheckedModeBanner: false,
      // theme: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.getRoutes(isDarkMode: _isDarkMode, onToggleTheme: _toggleTheme),
    );
  }
}
