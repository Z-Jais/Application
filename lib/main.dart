import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('Error: ${details.exception} StackTrace: ${details.stack}');
  };

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
    return MaterialApp.router(
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
      routerConfig: GoRouter(
        initialLocation: '/0',
        errorBuilder: (_, GoRouterState state) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${state.location}\n\n${state.error}'),
            ),
          );
        },
        routes: <GoRoute>[
          GoRoute(
            path: '/:page',
            builder: (_, GoRouterState state) {
              final int page = int.parse(state.params['page'] ?? '0');
              changePage(page);

              return SafeArea(
                child: ChangeNotifierProvider<NavbarMapper>.value(
                  value: NavbarMapper.instance,
                  child: Consumer<NavbarMapper>(
                    builder:
                        (BuildContext context, NavbarMapper navbarMapper, __) {
                      final bool onMobile = DisplayMapper.isOnMobile(context);

                      return Scaffold(
                        resizeToAvoidBottomInset: false,
                        body: Column(
                          children: <Widget>[
                            Navbar(
                              onPageChanged: changePage,
                              webWidgets:
                                  navbarMapper.itemsTopNavBar((int index) => context.go('/$index')),
                              topWidgets: navbarMapper.currentPage == 2
                                  ? <Widget>[
                                      IconButton(
                                        onPressed: () => context.go('/search'),
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
                                selectedItemColor:
                                    Theme.of(context).primaryColor,
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
          ),
          GoRoute(
            path: '/search',
            builder: (_, __) {
              return const SafeArea(child: AnimeSearchView());
            },
          ),
          GoRoute(
            path: '/anime/:uuid',
            builder: (_, GoRouterState state) {
              final String uuid = state.params['uuid']!;

              return SafeArea(child: AnimeDetailView(uuid: uuid));
            },
          ),
        ],
      ),
    );
  }
}
