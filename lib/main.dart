import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/views/animes/anime_detail_view.dart';
import 'package:jais/views/animes/anime_diary_view.dart';
import 'package:jais/views/animes/anime_search_view.dart';
import 'package:jais/views/initialization_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    error('FlutterError', '.onError', details.exception, details.stack);
  };

  // debugRepaintRainbowEnabled = kDebugMode;
  // debugRepaintTextRainbowEnabled = kDebugMode;

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const Color _mainWhiteThemeColor = Color(0xFFa32d26);
  static const Color _mainDarkThemeColor = Color(0xFFfde5c9);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    info('MyApp', 'build()');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: _mainWhiteThemeColor,
        scaffoldBackgroundColor: const Color(0xFFF0F0F0),
        colorScheme: ColorScheme.fromSeed(seedColor: _mainWhiteThemeColor)
            .copyWith(background: Colors.white),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        primaryColor: _mainDarkThemeColor,
        scaffoldBackgroundColor: const Color(0xFF101010),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          primarySwatch: MaterialColor(_mainDarkThemeColor.value, {
            for (var i = 50; i <= 900; i += 50)
              i: Color.fromRGBO(
                _mainDarkThemeColor.red,
                _mainDarkThemeColor.green,
                _mainDarkThemeColor.blue,
                i / 100,
              ),
          }),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InitializationView(),
        '/anime/search': (_) {
          return AnimeSearchView(controller: AnimeSearchController());
        },
        '/anime/detail': (_) {
          return AnimeDetailView(controller: AnimeDetailController());
        },
        '/anime/diary': (_) {
          return AnimeDiaryView(controller: AnimeDiaryController());
        },
      },
    );
  }
}
