import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/platforms/windows_platform_controller.dart';
import 'package:jais/views/animes/anime_detail_view.dart';
import 'package:jais/views/animes/anime_diary_view.dart';
import 'package:jais/views/animes/anime_search_view.dart';
import 'package:jais/views/initialization_view.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await WindowsPlatformController().init();
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget with WindowListener {
  MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  static const Color _mainColor = Color(0xFFF2B05E);

  @override
  void initState() {
    log('_MyAppState.initState()');
    windowManager.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('_MyAppState.build()');

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

  @override
  void onWindowMinimize() {
    windowManager.hide();
    super.onWindowMinimize();
  }

  @override
  void onWindowRestore() {
    setState(() { });
    super.onWindowRestore();
  }
}
