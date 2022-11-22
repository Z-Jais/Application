import 'package:custom_navigation_bar/custom_navigation_bar.dart';
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

  Iterable<CustomNavigationBarItem> itemsCustomNavBar(
    BuildContext context,
  ) =>
      items(context)
          .asMap()
          .map(
            (int i, NavbarLink e) => MapEntry<int, CustomNavigationBarItem>(
              i,
              e.toCustomNavigationBarItem,
            ),
          )
          .values;
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

  CustomNavigationBarItem get toCustomNavigationBarItem =>
      CustomNavigationBarItem(
        icon: icon,
        // title: Text(name),
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
