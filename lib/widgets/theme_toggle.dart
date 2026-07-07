import "package:flutter/material.dart";

import "../app_state.dart";

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.instance;
    return IconButton(
      icon: Icon(appState.isDarkMode ? Icons.light_mode : Icons.dark_mode),
      onPressed: appState.toggleTheme,
      tooltip: appState.isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode",
    );
  }
}
