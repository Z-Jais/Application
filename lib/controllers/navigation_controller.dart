import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/models/navigation_bar_item.dart';

class NavigationController with ChangeNotifier {
  static final NavigationController instance = NavigationController();
  final PageController pageController = PageController();
  int _currentPage = 0;
  bool _inProgress = false;

  int get currentPage => _currentPage;

  void setCurrentPage(int page) {
    if (_inProgress) return;
    _inProgress = true;
    debug('NavigationController', '$currentPage -> $page');

    if (page == currentPage) {
      _inProgress = false;
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

    _inProgress = false;
  }

  List<NavigationBarItem> _items(BuildContext context) {
    return [
      NavigationBarItem(
        name: AppLocalizations.of(context)!.episodes(2),
        selectedIcon: const Icon(Icons.subscriptions),
        icon: const Icon(Icons.subscriptions_outlined),
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
          topWidgets: [
            const NavigationBarItem(
              name: 'Paramètres',
              icon: Icon(Icons.settings),
              route: '/profile/settings',
            ),
          ]),
    ];
  }

  Iterable<NavigationDestination> bottomNavigationBarItems(
          BuildContext context) =>
      _items(context)
          .map((NavigationBarItem item) => item.toNavigationDestination());

  List<NavigationBarItem>? currentTopNavigationBarItems(BuildContext context) =>
      _items(context)[currentPage].topWidgets;
}
