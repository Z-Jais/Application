import 'package:flutter/material.dart';
import 'package:jais/utils/utils.dart';

class NavbarMapper extends ChangeNotifier {
  static final NavbarMapper instance = NavbarMapper();
  late PageController pageController;

  NavbarMapper({int defaultPage = 0})
      : pageController = PageController(initialPage: defaultPage);

  int get currentPage {
    try {
      return pageController.page?.toInt() ?? 0;
    } catch (e) {
      return 0;
    }
  }

  set currentPage(int page) {
    try {
      pageController.jumpToPage(page);
    } catch (_) {
      pageController = PageController(initialPage: page);
    }

    notifyListeners();
    Utils.clearImagesCache();
  }

  List<NavbarLink> items(BuildContext context) => <NavbarLink>[
        const NavbarLink(
          name: 'Épisodes',
          icon: Icon(Icons.subscriptions_outlined),
        ),
        NavbarLink(
          name: 'Mangas',
          icon: const Icon(Icons.menu_book),
          topWidgets: <Widget>[
            IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/manga/scan');
              },
              icon: const Icon(Icons.document_scanner),
            ),
            // IconButton(
            //   onPressed: () async {
            //     Navigator.of(context).pushNamed('/manga/planned');
            //   },
            //   icon: const Icon(Icons.calendar_month),
            // ),
          ],
        ),
        NavbarLink(
          name: 'Animes',
          icon: const Icon(Icons.live_tv),
          topWidgets: <Widget>[
            IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/anime/search');
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/anime/diary');
              },
              icon: const Icon(Icons.calendar_view_week),
            ),
          ],
        ),
      ];

  Iterable<BottomNavigationBarItem> itemsBottomNavBar(
    BuildContext context,
  ) =>
      items(context)
          .asMap()
          .map(
            (int i, NavbarLink e) => MapEntry<int, BottomNavigationBarItem>(
              i,
              e.toBottomNavigationBarItem,
            ),
          )
          .values;
}

class NavbarLink {
  final String name;
  final Icon icon;
  final List<Widget>? topWidgets;

  const NavbarLink({
    required this.name,
    required this.icon,
    this.topWidgets,
  });

  BottomNavigationBarItem get toBottomNavigationBarItem =>
      BottomNavigationBarItem(
        icon: icon,
        label: name,
      );
}
