import "package:flutter/material.dart";

import "theme_toggle.dart";
import "../services/auth_service.dart";

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.onToggleTheme,
    this.actions,
  });

  void _logout(BuildContext context) {
    AuthService().logout();
    Navigator.of(context).pushReplacementNamed("/login");
  }

  // void _openDrawer(BuildContext context) {
  //   Scaffold.of(context).openDrawer();
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // leading: IconButton(
      //   icon: const Icon(Icons.menu),
      //   onPressed: () => _openDrawer(context),
      //   tooltip: "Menu",
      // ),
      title: Text(title),
      actions: [
        ...?actions,
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _logout(context),
          tooltip: "Logout",
        ),
        ThemeToggle(isDark: isDarkMode, onToggle: onToggleTheme),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}