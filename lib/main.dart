import 'package:flutter/material.dart';
import 'package:jais/views/animes/anime_detail_view.dart';
import 'package:jais/views/animes/anime_diary_view.dart';
import 'package:jais/views/animes/anime_search_view.dart';
import 'package:jais/views/animes/animes_recommendation_view.dart';
import 'package:jais/views/initialization_view.dart';
import 'package:jais/views/mangas/manga_scan_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const Color _mainColor = Color(0xFFF2B05E);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        useMaterial3: true,
        primaryColor: _mainColor,
        colorScheme: ColorScheme.fromSeed(seedColor: _mainColor),
      ),
      darkTheme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        useMaterial3: true,
        primaryColor: _mainColor,
        primarySwatch: MaterialColor(_mainColor.value, {
          for (var i = 50; i <= 900; i += 50)
            i: Color.fromRGBO(
              _mainColor.red,
              _mainColor.green,
              _mainColor.blue,
              i / 100,
            ),
        }),
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InitializationView(),
        '/manga/scan': (_) {
          return const SafeArea(child: MangaScanView());
        },
        '/anime/search': (_) {
          return const SafeArea(child: AnimeSearchView());
        },
        '/anime/detail': (_) {
          return const SafeArea(child: AnimeDetailView());
        },
        '/anime/diary': (_) {
          return const SafeArea(child: AnimeDiaryView());
        },
        '/anime/recommendations': (_) {
          return const SafeArea(child: AnimesRecommendationView());
        },
      },
    );
  }
}
