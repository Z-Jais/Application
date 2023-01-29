import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/firebase_options.dart';
import 'package:jais/views/animes/anime_detail_view.dart';
import 'package:jais/views/animes/anime_diary_view.dart';
import 'package:jais/views/animes/anime_search_view.dart';
import 'package:jais/views/initialization_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MobileAds.instance.initialize();

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
        colorScheme: ColorScheme.fromSeed(seedColor: _mainColor),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        primaryColor: _mainColor,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          primarySwatch: MaterialColor(_mainColor.value, {
            for (var i = 50; i <= 900; i += 50)
              i: Color.fromRGBO(
                _mainColor.red,
                _mainColor.green,
                _mainColor.blue,
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
