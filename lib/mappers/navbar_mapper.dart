import 'package:flutter/material.dart';
import 'package:jais/utils/utils.dart';

class NavbarMapper extends ChangeNotifier {
  static final NavbarMapper instance = NavbarMapper();
  late final PageController pageController;

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
    pageController.jumpToPage(page);
    notifyListeners();
    Utils.clearImagesCache();
  }

  List<NavbarLink> get items => <NavbarLink>[
        const NavbarLink(
          name: 'Épisodes',
          icon: Icon(Icons.subscriptions),
        ),
        const NavbarLink(
          name: 'Mangas',
          icon: Icon(Icons.menu_book),
        ),
        const NavbarLink(
          name: 'Animes',
          icon: Icon(Icons.live_tv),
        ),
      ];

  Iterable<BottomNavigationBarItem> get itemsBottomNavBar =>
      items.map((NavbarLink e) => e.toBottomNavigationBarItem());

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

  const NavbarLink({
    required this.name,
    required this.icon,
  });

  BottomNavigationBarItem toBottomNavigationBarItem() =>
      BottomNavigationBarItem(
        icon: icon,
        label: name,
      );

  TextButton toTextButton({Function()? onPressed}) => TextButton(
        onPressed: onPressed,
        child: Text(name),
      );
}
