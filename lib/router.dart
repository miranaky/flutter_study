import 'package:go_router/go_router.dart';
import 'package:thread_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:thread_clone/features/settings/views/privacy_screen.dart';
import 'package:thread_clone/features/settings/views/settings_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/:tab(|search|activity|profile)",
      name: MainNavScreen.routeName,
      builder: (context, state) {
        final tab = state.pathParameters["tab"] ?? "";
        return MainNavScreen(tab: tab);
      },
    ),
    GoRoute(
      name: SettingsScreen.routeName,
      path: SettingsScreen.routeURL,
      builder: (context, state) => const SettingsScreen(),
      routes: [
        GoRoute(
          name: PrivacyScreen.routeName,
          path: PrivacyScreen.routeURL,
          builder: (context, state) => const PrivacyScreen(),
        ),
      ],
    ),
  ],
);
