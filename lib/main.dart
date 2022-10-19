import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/ads/banner_ad.dart';
import 'package:jais/components/navbar.dart';
import 'package:jais/mappers/country_mapper.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/utils/color.dart';
import 'package:jais/views/anime_detail_view.dart';
import 'package:jais/views/anime_search_view.dart';
import 'package:jais/views/animes_view.dart';
import 'package:jais/views/episodes_view.dart';
import 'package:jais/views/manga_search_view.dart';
import 'package:jais/views/mangas_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await MobileAds.instance.initialize();
    await createGlobalBanner();
  } catch (_) {}

  DeviceMapper.updateOriginDevice();
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
        '/': (_) {
          return SafeArea(
            child: ChangeNotifierProvider<NavbarMapper>.value(
              value: NavbarMapper.instance,
              child: Consumer<NavbarMapper>(
                builder: (BuildContext context, NavbarMapper navbarMapper, __) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Column(
                      children: <Widget>[
                        Navbar(
                          onPageChanged: changePage,
                          topWidgets: <Widget>[
                            if (navbarMapper.currentPage == 1)
                              IconButton(
                                onPressed: () async {
                                  try {
                                    final String ean =
                                        await FlutterBarcodeScanner.scanBarcode(
                                      '#ff6666',
                                      'Annuler',
                                      true,
                                      ScanMode.BARCODE,
                                    );

                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (_) {
                                        return MangaSearchView(ean: ean);
                                      },
                                    );
                                  } catch (_) {}
                                },
                                icon: const Icon(Icons.document_scanner),
                              ),
                            if (navbarMapper.currentPage == 2)
                              IconButton(
                                onPressed: () async {
                                  Navigator.of(context).pushNamed('/search');
                                },
                                icon: const Icon(Icons.search),
                              ),
                          ],
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
                    bottomNavigationBar: BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedItemColor: Theme.of(context).primaryColor,
                      unselectedItemColor: Colors.grey,
                      currentIndex: navbarMapper.currentPage,
                      onTap: changePage,
                      items: <BottomNavigationBarItem>[
                        ...navbarMapper.itemsBottomNavBar
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
        '/search': (_) {
          return const SafeArea(child: AnimeSearchView());
        },
        '/anime': (_) {
          return const SafeArea(child: AnimeDetailView());
        },
      },
    );
  }
}
