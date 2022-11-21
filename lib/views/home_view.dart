import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/navbar.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/views/animes/animes_view.dart';
import 'package:jais/views/animes/animes_watchlist_view.dart';
import 'package:jais/views/episodes/episodes_view.dart';
import 'package:jais/views/episodes/episodes_watchlist_view.dart';
import 'package:jais/views/mangas/mangas_view.dart';
import 'package:jais/views/mangas/mangas_watchlist_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isList = false;

  void changePage(int page, {bool fromNavBar = false}) {
    if (fromNavBar && page == NavbarMapper.instance.currentPage) {
      _isList = !_isList;
      setState(() {});
      return;
    }

    if (_isList) {
      _isList = false;
      setState(() {});
    }

    NavbarMapper.instance.currentPage = page;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavbarMapper>.value(
      value: NavbarMapper.instance,
      child: Consumer<NavbarMapper>(
        builder: (BuildContext context, NavbarMapper navbarMapper, __) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: Column(
              children: <Widget>[
                Navbar(
                  onPageChanged: changePage,
                  topWidgets: NavbarMapper.instance
                      .items(context)[navbarMapper.currentPage]
                      .topWidgets,
                ),
                Expanded(
                  child: PageView(
                    controller: navbarMapper.pageController,
                    onPageChanged: changePage,
                    children: <Widget>[
                      _isList
                          ? const EpisodesWatchlistView()
                          : const EpisodesView(),
                      _isList
                          ? const MangasWatchlistView()
                          : const MangasView(),
                      _isList
                          ? const AnimesWatchlistView()
                          : const AnimesView(),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: CustomNavigationBar(
              selectedColor: Theme.of(context).primaryColor,
              strokeColor: Theme.of(context).primaryColor,
              unSelectedColor: Colors.grey,
              currentIndex: navbarMapper.currentPage,
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.95),
              borderRadius: const Radius.circular(20),
              onTap: (int page) {
                changePage(page, fromNavBar: true);
              },
              items: <CustomNavigationBarItem>[
                ...navbarMapper.itemsCustomNavBar(context),
              ],
              isFloating: true,
            ),
          );
        },
      ),
    );
  }
}
