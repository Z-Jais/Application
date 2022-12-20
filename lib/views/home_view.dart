import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/episode_controller.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:jais/views/animes/animes_view.dart';
import 'package:jais/views/animes/animes_watchlist_view.dart';
import 'package:jais/views/episodes/episodes_watchlist_view.dart';
import 'package:jais/widgets/episodes/episode_list2.dart';
import 'package:jais/widgets/navbar.dart';
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
            const Navbar(),
            Expanded(
              child: ChangeNotifierProvider.value(
                value: NavigationController.instance,
                child: Consumer<NavigationController>(
                  builder: (_, value, __) {
                    return PageView(
                      controller: value.pageController,
                      onPageChanged: value.setCurrentPage,
                      children: [
                        EpisodeList2(
                          episodeController: EpisodeController(limit: 12),
                        ),
                        if (value.advancedView)
                          AnimesWatchlistView()
                        else
                          EpisodesWatchlistView(),
                        const AnimesView(),
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
