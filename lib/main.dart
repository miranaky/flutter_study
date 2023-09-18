import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thread_clone/features/settings/repos/darkmode_config_repo.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';
import 'package:thread_clone/firebase_options.dart';
import 'package:thread_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final preference = await SharedPreferences.getInstance();
  final repository = DarkModeConfigRepository(preference);

  runApp(
    ProviderScope(
      overrides: [
        darkModeConfigViewModelProvider.overrideWith(
          () => DarkModeConfigViewModel(repository),
        ),
      ],
      child: const ThreadApp(),
    ),
  );
}

class ThreadApp extends ConsumerWidget {
  const ThreadApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Thread',
      themeMode: ref.watch(darkModeConfigViewModelProvider).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        textTheme: Typography.blackMountainView,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade900,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        brightness: Brightness.dark,
        textTheme: Typography.whiteMountainView,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
          surfaceTintColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade500,
        ),
        useMaterial3: true,
      ),
    );
  }
}
