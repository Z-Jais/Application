import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:jais/views/animes/anime_tab.dart';
import 'package:jais/views/episodes/episode_tab.dart';
import 'package:jais/views/episodes/episode_watchlist_tab.dart';
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
                  builder: (_, value, __) {
                    if (AppController.isAndroidOrIOS) {
                      return MyPage(controller: value);
                    }

                    return Row(
                      children: [
                        Column(
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 8)),
                            ...value.slideButtons(context),
                          ],
                        ),
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        Expanded(child: MyPage(controller: value)),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppController.isAndroidOrIOS
          ? ChangeNotifierProvider.value(
              value: NavigationController.instance,
              child: Consumer<NavigationController>(
                builder: (_, value, __) {
                  return BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Colors.grey,
                    currentIndex: value.currentPage,
                    onTap: value.setCurrentPage,
                    items: value.bottomNavigationBarItems.toList(),
                  );
                },
              ),
            )
          : null,
    );
  }
}

class MyPage extends StatelessWidget {
  final NavigationController controller;

  const MyPage({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.setCurrentPage,
      children: const [
        // EPISODES TAB
        EpisodeTab(),
        // WATCHLIST TAB
        EpisodeWatchlistTab(),
        // ANIME TAB
        AnimeTab(),
      ],
    );
  }
}
