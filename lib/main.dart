import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/firebase_options.dart';
import 'package:jais/mappers/country_mapper.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/utils/color.dart';
import 'package:jais/views/anime_detail_view.dart';
import 'package:jais/views/anime_search_view.dart';
import 'package:jais/views/diary_view.dart';
import 'package:jais/views/initialization_view.dart';
import 'package:jais/views/manga_scan_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await MobileAds.instance.initialize();
  } catch (_) {}

  DeviceMapper.updateOriginDevice();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (_) async => await FirebaseMessaging.instance.subscribeToTopic('all'),
  );

  await Future.wait(<Future<void>>[CountryMapper.instance.update()]);
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
        '/search': (_) {
          return const SafeArea(child: AnimeSearchView());
        },
        '/anime': (_) {
          return const SafeArea(child: AnimeDetailView());
        },
        '/scan': (_) {
          return const SafeArea(child: MangaScanView());
        },
        '/diary': (_) {
          return const SafeArea(child: DiaryView());
        },
      },
    );
  }
}
