import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  // final bool isDarkMode;
  // final VoidCallback onToggleTheme;
  // const HomeScreen({super.key, required this.isDarkMode, required this.onToggleTheme});
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home Screen", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
