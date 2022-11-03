import 'package:flutter/material.dart';
import 'package:jais/components/navbar.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/views/animes/animes_view.dart';
import 'package:jais/views/animes/animes_watchlist_view.dart';
import 'package:jais/views/episodes/episodes_view.dart';
import 'package:jais/views/episodes/episodes_watchlist_view.dart';
import 'package:jais/views/mangas/mangas_view.dart';
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
            body: Column(
              children: <Widget>[
                Navbar(
                  onPageChanged: changePage,
                  topWidgets: <Widget>[
                    if (navbarMapper.currentPage == 1)
                      IconButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamed('/scan');
                        },
                        icon: const Icon(Icons.document_scanner),
                      ),
                    if (navbarMapper.currentPage == 2) ...<Widget>[
                      IconButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamed('/search');
                        },
                        icon: const Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamed('/diary');
                        },
                        icon: const Icon(Icons.calendar_view_week),
                      ),
                    ],
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: navbarMapper.pageController,
                    onPageChanged: changePage,
                    children: <Widget>[
                      _isList
                          ? const EpisodesWatchlistView()
                          : const EpisodesView(),
                      const MangasView(),
                      _isList
                          ? const AnimesWatchlistView()
                          : const AnimesView(),
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
              onTap: (int page) {
                changePage(page, fromNavBar: true);
              },
              items: <BottomNavigationBarItem>[
                ...navbarMapper.itemsBottomNavBar(_isList),
              ],
            ),
          );
        },
      ),
    );
  }
}
