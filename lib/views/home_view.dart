import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:jais/components/navbar.dart';
import 'package:jais/components/no_connection.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/views/animes_view.dart';
import 'package:jais/views/animes_watchlist_view.dart';
import 'package:jais/views/episodes_view.dart';
import 'package:jais/views/mangas_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<bool> _hasInternet = DeviceMapper.hasInternet();
  bool _isList = false;

  Future<void> _needsReview() async {
    final bool showRequestReview =
        await DeviceMapper.reviewMapper.canShowReview();

    if (!mounted || !showRequestReview) {
      return;
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Aimez-vous notre application ?'),
          content: const Text('Voulez-vous laisser un avis ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Non'),
              onPressed: () async {
                Navigator.pop(context);
                await DeviceMapper.reviewMapper.neverReview();
              },
            ),
            TextButton(
              child: const Text('Plus tard'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Oui'),
              onPressed: () async {
                Navigator.pop(context);
                await DeviceMapper.reviewMapper.acceptReview();
                InAppReview.instance.requestReview();
              },
            )
          ],
        );
      },
    );
  }

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _needsReview();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasInternet,
      builder: (_, AsyncSnapshot<bool> snapshot) {
        debugPrint('snapshot.connectionState: ${snapshot.connectionState}');

        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.data!) {
          debugPrint('No internet connection');
          return Scaffold(
            body: NoConnection(
              onRetry: () async {
                _hasInternet = DeviceMapper.hasInternet();
                setState(() {});
              },
            ),
          );
        }

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
                          const EpisodesView(),
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
      },
    );
  }
}
