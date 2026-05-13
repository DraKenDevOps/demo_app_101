import "package:flutter/material.dart";

class ProfileScreen extends StatelessWidget {
  // final bool isDarkMode;
  // final VoidCallback onToggleTheme;
  // const HomeScreen({super.key, required this.isDarkMode, required this.onToggleTheme});
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
