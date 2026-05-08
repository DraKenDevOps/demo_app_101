import "package:flutter/material.dart";
import "theme_toggle.dart";

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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        ...?actions,
        ThemeToggle(isDark: isDarkMode, onToggle: onToggleTheme),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
