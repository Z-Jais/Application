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
      icon: Icon(Icons.subscriptions_outlined),
    ),
    NavigationBarItem(
      name: 'Watchlist',
      icon: const Icon(Icons.list),
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
      icon: Icon(Icons.live_tv),
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
  ];
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setCurrentPage(int page) {
    debug('NavigationController', '$currentPage -> $page');
    // Detect scroll direction

    if (page == currentPage) {
      return;
    }

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

  Iterable<BottomNavigationBarItem> get bottomNavigationBarItems =>
      _items.map((NavigationBarItem item) => item.toBottomNavigationBarItem());
  List<NavigationBarItem>? get currentTopNavigationBarItems =>
      _items[currentPage].topWidgets;

  List<Widget> slideButtons(BuildContext context) => _items.map(
        (NavigationBarItem item) {
          final int index = _items.indexOf(item);

          return IconButton(
            onPressed: () => setCurrentPage(index),
            padding: const EdgeInsets.all(16),
            color: currentPage == index ? Theme.of(context).primaryColor : null,
            icon: Flex(
              direction: Axis.vertical,
              children: [
                item.icon,
                Text(item.name),
              ],
            ),
          );
        },
      ).toList();
}
