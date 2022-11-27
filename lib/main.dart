import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:jais/utils/color.dart';
import 'package:jais/views/animes/anime_detail_view.dart';
import 'package:jais/views/animes/anime_diary_view.dart';
import 'package:jais/views/animes/anime_search_view.dart';
import 'package:jais/views/initialization_view.dart';
import 'package:jais/views/mangas/manga_scan_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
  debugPrint(
    'Platform : ${Platform.operatingSystem} - ${Platform.operatingSystemVersion}',
  );
  debugPrint(
    'Device : ${androidInfo.model} - Android ${androidInfo.version.release}',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final Color _mainColor = mainColors[900]!;

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
        primarySwatch: MaterialColor(_mainColor.value, mainColors),
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      routes: <String, Widget Function(BuildContext)>{
        '/': (_) {
          return const SafeArea(child: InitializationView());
        },
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
      },
    );
  }
}
