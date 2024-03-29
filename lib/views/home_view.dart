import 'package:flutter/material.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:jais/views/animes/anime_tab.dart';
import 'package:jais/views/episode_tab.dart';
import 'package:jais/views/profile/profile_tab.dart';
import 'package:jais/widgets/top_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    info('HomeView', 'build()');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const TopNavigationBar(),
            Expanded(
              child: ChangeNotifierProvider.value(
                value: NavigationController.instance,
                child: Consumer<NavigationController>(
                  builder: (context, value, child) {
                    return const MyPage();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ChangeNotifierProvider.value(
        value: NavigationController.instance,
        child: Consumer<NavigationController>(
          builder: (context, value, child) {
            return NavigationBar(
              selectedIndex: value.currentPage,
              onDestinationSelected: value.setCurrentPage,
              destinations: value.bottomNavigationBarItems(context).toList(),
              indicatorColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).colorScheme.background,
            );
          },
        ),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: NavigationController.instance.pageController,
      onPageChanged: NavigationController.instance.setCurrentPage,
      children: const [
        // EPISODES TAB
        EpisodeTab(),
        // WATCHLIST TAB
        // EpisodeWatchlistTab(),
        // ANIME TAB
        AnimeTab(),
        // PROFILE TAB
        ProfileTab(),
      ],
    );
  }
}
