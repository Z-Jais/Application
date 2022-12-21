import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/animes/anime_watchlist_controller.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/controllers/episodes/episode_watchlist_controller.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:jais/controllers/simulcast_controller.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/animes/anime_tab.dart';
import 'package:jais/widgets/episodes/episode_list.dart';
import 'package:jais/widgets/top_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    log('HomeView.build()');

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const TopNavigationBar(),
            Expanded(
              child: ChangeNotifierProvider.value(
                value: NavigationController.instance,
                child: Consumer<NavigationController>(
                  builder: (_, value, __) {
                    return PageView(
                      controller: value.pageController,
                      onPageChanged: value.setCurrentPage,
                      children: [
                        EpisodeList(
                          controller: EpisodeController(),
                        ),
                        if (value.advancedView)
                          AnimeList(
                            controller: AnimeWatchlistController(),
                          )
                        else
                          EpisodeList(
                            controller: EpisodeWatchlistController(),
                          ),
                        AnimeTab(
                          simulcastController: SimulcastController(),
                          animeController: AnimeController(firstLoad: false),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ChangeNotifierProvider.value(
          value: NavigationController.instance,
          child: Consumer<NavigationController>(
            builder: (_, value, __) {
              return BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.grey,
                currentIndex: value.currentPage,
                onTap: (page) =>
                    value.setCurrentPage(page, fromNavigationBar: true),
                items: value.bottomNavigationBarItems.toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
