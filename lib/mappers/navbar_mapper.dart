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

  List<NavbarLink> get items => <NavbarLink>[
        const NavbarLink(
          name: 'Épisodes',
          icon: Icon(Icons.subscriptions_outlined),
          listIcon: Icon(Icons.checklist),
        ),
        const NavbarLink(
          name: 'Mangas',
          icon: Icon(Icons.menu_book),
          listIcon: Icon(Icons.library_books),
        ),
        const NavbarLink(
          name: 'Animes',
          icon: Icon(Icons.live_tv),
          listIcon: Icon(Icons.tv),
        ),
      ];

  Iterable<BottomNavigationBarItem> itemsBottomNavBar(bool isList) => items
      .asMap()
      .map(
        (int i, NavbarLink e) => MapEntry<int, BottomNavigationBarItem>(
          i,
          e.toBottomNavigationBarItem(currentPage == i && isList),
        ),
      )
      .values;

  Iterable<Widget> itemsTopNavBar([Function(int)? callback]) => items
      .asMap()
      .map(
        (int i, NavbarLink e) => MapEntry<int, TextButton>(
          i,
          e.toTextButton(onPressed: () => callback?.call(i)),
        ),
      )
      .values;
}

class NavbarLink {
  final String name;
  final Icon icon;
  final Icon listIcon;

  const NavbarLink({
    required this.name,
    required this.icon,
    required this.listIcon,
  });

  BottomNavigationBarItem toBottomNavigationBarItem(bool isList) =>
      BottomNavigationBarItem(
        icon: isList ? listIcon : icon,
        label: name,
      );

  TextButton toTextButton({Function()? onPressed}) => TextButton(
        onPressed: onPressed,
        child: Text(name),
      );
}
