import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "app_state.dart";
import "layouts/main_layout.dart";
import "screens/detail_screen.dart";
import "screens/home_screen.dart";
import "screens/login_screen.dart";
import "screens/profile_screen.dart";
import "screens/settings_screen.dart";

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/login",
  refreshListenable: AppState.instance,
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = AppState.instance.isAuthenticated;
    final bool isOnLogin = state.matchedLocation == "/login";
    if (!loggedIn && !isOnLogin) return "/login";
    if (loggedIn && isOnLogin) return "/";
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: "/login",
      builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return MainLayout(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: "/",
              builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: "/profile",
              builder: (BuildContext context, GoRouterState state) => const ProfileScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: "/settings",
              builder: (BuildContext context, GoRouterState state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/detail/:id",
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        final int id = int.parse(state.pathParameters["id"]!);
        return DetailScreen(id: id);
      },
    ),
  ],
);
