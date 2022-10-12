import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/ads/banner_ad.dart';
import 'package:jais/components/navbar.dart';
import 'package:jais/mappers/country_mapper.dart';
import 'package:jais/mappers/display_mapper.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/utils/ad_utils.dart';
import 'package:jais/utils/color.dart';
import 'package:jais/views/anime_detail_view.dart';
import 'package:jais/views/anime_search_view.dart';
import 'package:jais/views/animes_view.dart';
import 'package:jais/views/episodes_view.dart';
import 'package:jais/views/mangas_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (AdUtils.canShowAd) {
    try {
      await MobileAds.instance.initialize();
      await createGlobalBanner();
    } catch (_) {}
  }

  await Future.wait(<Future<void>>[CountryMapper.instance.update()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final Color _mainColor = mainColors[900]!;

  const MyApp({super.key});

  void changePage(int page) => NavbarMapper.instance.currentPage = page;

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
        '/': (BuildContext context) {
          final bool onMobile = DisplayMapper.isOnMobile(context);

          return SafeArea(
            child: ChangeNotifierProvider<NavbarMapper>.value(
              value: NavbarMapper.instance,
              child: Consumer<NavbarMapper>(
                builder: (_, NavbarMapper navbarMapper, __) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Column(
                      children: <Widget>[
                        Navbar(
                          onPageChanged: changePage,
                          webWidgets: navbarMapper.itemsTopNavBar(changePage),
                          topWidgets: navbarMapper.currentPage == 2
                              ? <Widget>[
                                  IconButton(
                                    onPressed: () async =>
                                        Navigator.pushNamed(context, '/search'),
                                    icon: const Icon(Icons.search),
                                  ),
                                ]
                              : null,
                        ),
                        Expanded(
                          child: PageView(
                            controller: navbarMapper.pageController,
                            onPageChanged: changePage,
                            children: const <Widget>[
                              EpisodesView(),
                              MangasView(),
                              AnimesView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: ((kIsWeb && onMobile) || onMobile)
                        ? BottomNavigationBar(
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            selectedItemColor: Theme.of(context).primaryColor,
                            unselectedItemColor: Colors.grey,
                            currentIndex: navbarMapper.currentPage,
                            onTap: changePage,
                            items: <BottomNavigationBarItem>[
                              ...navbarMapper.itemsBottomNavBar
                            ],
                          )
                        : null,
                  );
                },
              ),
            ),
          );
        },
        '/anime': (_) {
          return const SafeArea(child: AnimeDetailView());
        },
        '/search': (_) {
          return const SafeArea(child: AnimeSearchView());
        }
      },
    );
  }
}
