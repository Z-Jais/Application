import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/views/animes/anime_detail_view.dart';
import 'package:jais/views/animes/anime_diary_view.dart';
import 'package:jais/views/animes/anime_search_view.dart';
import 'package:jais/views/initialization_view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const Color _mainColor = Color(0xFFF2B05E);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log('MyApp.build()');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: _mainColor,
        colorScheme: ColorScheme.fromSeed(seedColor: _mainColor).copyWith(
          brightness: Brightness.light,
          background: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        primaryColor: _mainColor,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(_mainColor.value, {
            for (var i = 50; i <= 900; i += 50)
              i: Color.fromRGBO(
                _mainColor.red,
                _mainColor.green,
                _mainColor.blue,
                i / 100,
              ),
          }),
        ).copyWith(
          brightness: Brightness.dark,
          background: Colors.black,
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
