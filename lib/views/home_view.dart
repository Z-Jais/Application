import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/views/animes/anime_tab.dart';
import 'package:jais/views/episodes/episode_tab.dart';
import 'package:jais/views/episodes/episode_watchlist_tab.dart';
import 'package:jais/widgets/decoration/round_border_decoration.dart';
import 'package:jais/widgets/top_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    info('HomeView', 'build()');

    return Scaffold(
      backgroundColor: context.isOnMobile ? context.mainBackgroundColor : null,
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
                      return const MyPage();
                    }

                    final withOpacity =
                        Theme.of(context).primaryColor.withOpacity(0.1);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          RoundBorderDecoration(
                            widget: ColoredBox(
                              color: withOpacity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    ...value.slideButtons(context),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RoundBorderDecoration(
                              widget: ColoredBox(
                                color: withOpacity,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: MyPage(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  return NavigationBar(
                    selectedIndex: value.currentPage,
                    onDestinationSelected: value.setCurrentPage,
                    destinations: value.bottomNavigationBarItems.toList(),
                    indicatorColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).colorScheme.background,
                  );
                },
              ),
            )
          : null,
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
        EpisodeWatchlistTab(),
        // ANIME TAB
        AnimeTab(),
      ],
    );
  }
}
