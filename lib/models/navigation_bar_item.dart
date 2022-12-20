import 'package:flutter/material.dart';

class NavigationBarItem {
  final String name;
  final Icon icon;
  final List<NavigationBarItem>? topWidgets;
  final String? route;

  const NavigationBarItem({
    required this.name,
    required this.icon,
    this.topWidgets,
    this.route,
  });

  BottomNavigationBarItem toBottomNavigationBarItem() =>
      BottomNavigationBarItem(
        icon: icon,
        label: name,
      );

  IconButton toIconButton(BuildContext context) => IconButton(
        icon: icon,
        onPressed: () {
          if (route != null) {
            Navigator.of(context).pushNamed(route!);
          }
        },
      );
}
