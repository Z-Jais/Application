import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/models/navigation_bar_item.dart';
import 'package:jais/widgets/filter_watchlist.dart';

class NavigationController with ChangeNotifier {
  static final NavigationController instance = NavigationController();
  final PageController pageController = PageController();
  final List<NavigationBarItem> _items = [
    const NavigationBarItem(
      name: 'Épisodes',
      selectedIcon: Icon(Icons.subscriptions),
      icon: Icon(Icons.subscriptions_outlined),
    ),
    NavigationBarItem(
      name: 'Watchlist',
      selectedIcon: const Icon(Icons.playlist_play),
      icon: const Icon(Icons.playlist_play_outlined),
      topWidgets: [
        NavigationBarItem(
          name: 'Filtre',
          icon: const Icon(Icons.filter_alt),
          onPressed: (BuildContext context) {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  const AlertDialog(content: FilterWatchlist()),
            );
          },
        ),
      ],
    ),
    const NavigationBarItem(
      name: 'Animes',
      selectedIcon: Icon(Icons.video_library),
      icon: Icon(Icons.video_library_outlined),
      topWidgets: [
        NavigationBarItem(
          name: 'Rechercher',
          icon: Icon(Icons.search),
          route: '/anime/search',
        ),
        NavigationBarItem(
          name: 'Agenda',
          icon: Icon(Icons.calendar_view_week),
          route: '/anime/diary',
        ),
      ],
    ),
    const NavigationBarItem(
      name: 'Profile',
      selectedIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outline_outlined),
    ),
  ];
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
      log(
        'Error while changing page',
        error: exception,
        stackTrace: stacktrace,
      );
    }
  }

  Iterable<NavigationDestination> get bottomNavigationBarItems =>
      _items.map((NavigationBarItem item) => item.toNavigationDestination());

  List<NavigationBarItem>? get currentTopNavigationBarItems =>
      _items[currentPage].topWidgets;
}
