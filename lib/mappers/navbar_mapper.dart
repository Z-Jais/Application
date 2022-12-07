import 'package:flutter/material.dart';
import 'package:jais/utils/utils.dart';

class NavbarMapper extends ChangeNotifier {
  static final NavbarMapper instance = NavbarMapper();
  late PageController pageController;
  bool _isList = false;

  NavbarMapper({int defaultPage = 0})
      : pageController = PageController(initialPage: defaultPage);

  int get currentPage {
    try {
      return pageController.page?.toInt() ?? 0;
    } catch (e) {
      return 0;
    }
  }

  bool get isList => _isList;

  set currentPage(int page) {
    try {
      pageController.jumpToPage(page);
    } catch (_) {
      pageController = PageController(initialPage: page);
    }

    notifyListeners();
    Utils.instance.clearImagesCache();
  }

  void changePage(int page, {bool fromNavBar = false}) {
    if (fromNavBar && page == currentPage) {
      Utils.instance.clearImagesCache();
      _isList = !_isList;
      notifyListeners();
      return;
    }

    if (_isList) {
      _isList = false;
    }

    Utils.instance.clearImagesCache();
    currentPage = page;
  }

  List<NavbarLink> items(BuildContext context) => <NavbarLink>[
        const NavbarLink(
          name: 'Épisodes',
          icon: Icon(Icons.subscriptions_outlined),
        ),
        NavbarLink(
          name: 'Mangas',
          icon: const Icon(Icons.menu_book),
          topWidgets: <NavbarLink>[
            NavbarLink(
              name: 'Scan',
              icon: const Icon(Icons.document_scanner),
              onTap: () async {
                Navigator.of(context).pushNamed('/manga/scan');
              },
            ),
          ],
        ),
        NavbarLink(
          name: 'Animes',
          icon: const Icon(Icons.live_tv),
          topWidgets: <NavbarLink>[
            NavbarLink(
              name: 'Rechercher',
              icon: const Icon(Icons.search),
              onTap: () async {
                Navigator.of(context).pushNamed('/anime/search');
              },
            ),
            NavbarLink(
              name: 'Agenda',
              icon: const Icon(Icons.calendar_view_week),
              onTap: () async {
                Navigator.of(context).pushNamed('/anime/diary');
              },
            ),
            NavbarLink(
              name: 'Recommandations',
              icon: const Icon(Icons.star),
              onTap: () async {
                Navigator.of(context).pushNamed('/anime/recommendations');
              },
            ),
          ],
        ),
      ];

  Iterable<BottomNavigationBarItem> itemsBottomNavBar(BuildContext context) =>
      items(context).map((e) => e.toBottomNavigationBarItem);
}

class NavbarLink {
  final String name;
  final Icon icon;
  final List<NavbarLink>? topWidgets;
  final VoidCallback? onTap;

  const NavbarLink({
    required this.name,
    required this.icon,
    this.topWidgets,
    this.onTap,
  });

  BottomNavigationBarItem get toBottomNavigationBarItem =>
      BottomNavigationBarItem(
        icon: icon,
        label: name,
      );

  IconButton get toIconButton => IconButton(
        icon: icon,
        onPressed: onTap,
      );

  ListTile get toListTile => ListTile(
        leading: icon,
        title: Text(name),
        onTap: onTap,
      );
}
