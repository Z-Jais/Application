import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:jais/views/animes/animes_view.dart';
import 'package:jais/views/animes/animes_watchlist_view.dart';
import 'package:jais/views/episodes/episodes_view.dart';
import 'package:jais/views/episodes/episodes_watchlist_view.dart';
import 'package:jais/widgets/jnavigation_bar.dart';
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
                        EpisodesView(),
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
        bottomNavigationBar: const JNavigationBar(),
      ),
    );
  }
}
