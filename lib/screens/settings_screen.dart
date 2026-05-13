import "package:flutter/material.dart";

class SettingsScreen extends StatelessWidget {
  // final bool isDarkMode;
  // final VoidCallback onToggleTheme;
  // const HomeScreen({super.key, required this.isDarkMode, required this.onToggleTheme});
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Settings Screen"),
      ),
    );
  }
}
