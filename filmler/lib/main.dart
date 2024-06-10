import 'package:filmler/screens/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/boarding_screen.dart';
import 'screens/films_screen.dart';
import 'screens/directors.dart';
import 'screens/postedfilms_screen.dart';
import 'language_notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider<LanguageNotifier>(
          create: (_) => LanguageNotifier(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: languageNotifier.isEnglish ? 'Movies' : 'Filmler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(body: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/boarding',
          builder: (context, state) => BoardingScreen(),
        ),
        GoRoute(
          path: '/films',
          builder: (context, state) => FilmsScreen(),
        ),
        GoRoute(
          path: '/directors',
          builder: (context, state) => DirectorsScreen(),
        ),
        GoRoute(
          path: '/myfilms',
          builder: (context, state) => PostedFilmsScreen(),
        ),
      ],
    ),
  ],
);
