import "package:flutter/material.dart";

import "../widgets/app_bar.dart";

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Settings",
        isDarkMode: isDarkMode,
        onToggleTheme: onToggleTheme,
      ),
      body: const Center(
        child: Text("Settings Screen"),
      ),
    );
  }
}
