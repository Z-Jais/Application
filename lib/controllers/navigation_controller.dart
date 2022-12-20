import 'package:flutter/material.dart';
import 'package:jais/models/navigation_bar_item.dart';

class NavigationController with ChangeNotifier {
  static final NavigationController instance = NavigationController();
  final PageController pageController = PageController();
  bool _advancedView = false;
  final List<NavigationBarItem> _items = [
    const NavigationBarItem(
      name: 'Épisodes',
      icon: Icon(Icons.subscriptions_outlined),
    ),
    const NavigationBarItem(
      name: 'Watchlist',
      icon: Icon(Icons.list),
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

  int get currentPage {
    try {
      return pageController.page?.toInt() ?? 0;
    } catch (e) {
      return 0;
    }
  }

  void setCurrentPage(int page, {bool fromNavigationBar = false}) {
    if (fromNavigationBar && page == currentPage) {
      _advancedView = !_advancedView;
      notifyListeners();
      return;
    }

    if (_advancedView) {
      _advancedView = false;
    }

    try {
      pageController.jumpToPage(page);
      notifyListeners();
    } catch (_) {}
  }

  bool get advancedView => _advancedView;

  Iterable<BottomNavigationBarItem> get bottomNavigationBarItems =>
      _items.map((NavigationBarItem item) => item.toBottomNavigationBarItem());
}
