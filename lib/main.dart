import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/ads/banner_ad.dart';
import 'package:jais/components/navbar.dart';
import 'package:jais/logger/logger.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/utils/color.dart';
import 'package:jais/views/episodes_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    Logger.error(
      'An error occurred with Flutter',
      details.exception,
      details.stack,
    );
  };

  try {
    Logger.info('Initializing Google Mobile Ads...');
    await MobileAds.instance.initialize();
    await createGlobalBanner();
  } catch (exception, stacktrace) {
    Logger.error(
      'An error occurred while initializing Google Mobile Ads',
      exception,
      stacktrace,
    );
  }

  Logger.info('Running app...');
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
      home: SafeArea(
        child: ChangeNotifierProvider<NavbarMapper>.value(
          value: NavbarMapper.instance,
          child: Consumer<NavbarMapper>(
            builder: (BuildContext context, NavbarMapper navbarMapper, _) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  children: <Widget>[
                    Navbar(
                      onPageChanged: (int page) =>
                          navbarMapper.currentPage = page,
                    ),
                    Expanded(
                      child: PageView(
                        controller: navbarMapper.pageController,
                        onPageChanged: (int i) => navbarMapper.currentPage = i,
                        children: const <Widget>[
                          EpisodesView(),
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: Theme.of(context).primaryColor,
                  unselectedItemColor: Colors.grey,
                  currentIndex: navbarMapper.currentPage,
                  onTap: (int index) => navbarMapper.currentPage = index,
                  items: navbarMapper.itemsBottomNavBar,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
