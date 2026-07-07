import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../app_state.dart";
import "theme_toggle.dart";

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  void _logout(BuildContext context) {
    AppState.instance.logout();
    context.go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: [
        ...?actions,
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _logout(context),
          tooltip: "Logout",
        ),
        ThemeToggle(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
