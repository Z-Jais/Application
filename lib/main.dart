import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/controllers/platforms/windows_platform_controller.dart';
import 'package:jais/views/animes/anime_detail_view.dart';
import 'package:jais/views/animes/anime_diary_view.dart';
import 'package:jais/views/animes/anime_search_view.dart';
import 'package:jais/views/initialization_view.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = kDebugMode;
  // debugRepaintTextRainbowEnabled = kDebugMode;

  if (AppController.isWindows) {
    await WindowsPlatformController.instance.init();
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
  static const Color _mainWhiteThemeColor = Color(0xFFa32d26);
  static const Color _mainDarkThemeColor = Color(0xFFfde5c9);

  @override
  void initState() {
    info('_MyAppState', 'initState()');
    windowManager.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    info('_MyAppState', 'build()');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: _mainWhiteThemeColor,
        colorScheme: ColorScheme.fromSeed(seedColor: _mainWhiteThemeColor),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        primaryColor: _mainDarkThemeColor,
        scaffoldBackgroundColor: Colors.black,
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

  @override
  void onWindowMinimize() {
    windowManager.hide();
    super.onWindowMinimize();
  }

  @override
  void onWindowRestore() {
    setState(() {});
    super.onWindowRestore();
  }
}
