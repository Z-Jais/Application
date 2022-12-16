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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Navbar(),
        Expanded(
          child: ChangeNotifierProvider<NavbarMapper>.value(
            value: NavbarMapper.instance,
            child: Consumer<NavbarMapper>(
              builder: (context, value, child) {
                return PageView(
                  controller: value.pageController,
                  onPageChanged: value.changePage,
                  children: <Widget>[
                    if (value.isList)
                      EpisodesWatchlistView()
                    else
                      EpisodesView(),
                    if (value.isList)
                      MangasWatchlistView()
                    else
                      MangasView(),
                    if (value.isList)
                      AnimesWatchlistView()
                    else
                      const AnimesView(),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
