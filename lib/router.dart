import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/features/authentication/login_screen.dart';
import 'package:thread_clone/features/authentication/repos/authentication_repo.dart';
import 'package:thread_clone/features/authentication/signup_screen.dart';
import 'package:thread_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:thread_clone/features/settings/views/privacy_screen.dart';
import 'package:thread_clone/features/settings/views/settings_screen.dart';

final routerProvider = Provider(
  (ref) {
    ref.watch(authStateStream);
    return GoRouter(
      redirect: (context, state) {
        final isLoggedIn = ref.watch(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != SignUpScreen.routeURL &&
              state.matchedLocation != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        }
        return null;
      },
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/login",
          name: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: "/signup",
          name: SignUpScreen.routeName,
          builder: (context, state) => const SignUpScreen(),
        ),
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
  },
);
