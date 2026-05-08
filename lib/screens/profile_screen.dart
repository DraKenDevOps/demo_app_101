import "package:flutter/material.dart";

import "../widgets/app_bar.dart";

class ProfileScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        isDarkMode: isDarkMode,
        onToggleTheme: onToggleTheme,
      ),
      body: const Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
