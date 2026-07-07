import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "app_state.dart";
import "router.dart";
import "theme.dart";
import "config.dart";
import "utils/http_client.dart";
import "services/storage_service.dart";

void main() async {
  await dotenv.load(fileName: ".env");

  HttpClient http = HttpClient();
  http.initialize(baseUrl: AppConfig.API_BASE_URL_V2);
  String? token = await StorageService.getToken();
  if (token != null && token.isNotEmpty) http.addHeader("Authorization", "Bearer $token");
  AppConfig.printAllEnv();

  final appState = AppState.instance;
  await appState.loadTheme();
  appState.isAuthenticated = await StorageService.hasToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        return MaterialApp.router(
          title: AppConfig.APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: AppState.instance.themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
