import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/models/navigation_bar_item.dart';
import 'package:jais/widgets/filter_watchlist.dart';

class NavigationController with ChangeNotifier {
  static final NavigationController instance = NavigationController();
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setCurrentPage(int page) {
    debug('NavigationController', '$currentPage -> $page');

    if (page == currentPage) {
      return;
    }

    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    try {
      pageController.jumpToPage(page);
      _currentPage = page;
      notifyListeners();
    } catch (exception, stacktrace) {
      error(
        'NavigationController',
        'Error while changing page',
        exception,
        stacktrace,
      );
    }
  }

  List<NavigationBarItem> _items(BuildContext context) {
    return [
      NavigationBarItem(
        name: AppLocalizations.of(context)!.episodes(2),
        selectedIcon: const Icon(Icons.subscriptions),
        icon: const Icon(Icons.subscriptions_outlined),
      ),
      NavigationBarItem(
        name: AppLocalizations.of(context)!.watchlist,
        selectedIcon: const Icon(Icons.playlist_play),
        icon: const Icon(Icons.playlist_play_outlined),
        topWidgets: [
          NavigationBarItem(
            name: AppLocalizations.of(context)!.filter,
            icon: const Icon(Icons.filter_list),
            onPressed: (BuildContext context) {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    const AlertDialog.adaptive(content: FilterWatchlist()),
              );
            },
          ),
        ],
      ),
      NavigationBarItem(
        name: AppLocalizations.of(context)!.animes(2),
        selectedIcon: const Icon(Icons.video_library),
        icon: const Icon(Icons.video_library_outlined),
        topWidgets: [
          NavigationBarItem(
            name: AppLocalizations.of(context)!.search,
            icon: const Icon(Icons.search),
            route: '/anime/search',
          ),
          NavigationBarItem(
            name: AppLocalizations.of(context)!.calendar,
            icon: const Icon(Icons.calendar_month),
            route: '/anime/calendar',
          ),
        ],
      ),
      NavigationBarItem(
        name: AppLocalizations.of(context)!.profile,
        selectedIcon: const Icon(Icons.person),
        icon: const Icon(Icons.person_outline_outlined),
      ),
    ];
  }

  Iterable<NavigationDestination> bottomNavigationBarItems(
          BuildContext context) =>
      _items(context)
          .map((NavigationBarItem item) => item.toNavigationDestination());

  List<NavigationBarItem>? currentTopNavigationBarItems(BuildContext context) =>
      _items(context)[currentPage].topWidgets;
}
