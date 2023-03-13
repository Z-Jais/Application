import 'package:flutter/material.dart';

class NavigationBarItem {
  final String name;
  final Icon icon;
  final List<NavigationBarItem>? topWidgets;
  final String? route;
  final void Function(BuildContext)? onPressed;

  const NavigationBarItem({
    required this.name,
    required this.icon,
    this.topWidgets,
    this.route,
    this.onPressed,
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
          } else if (onPressed != null) {
            onPressed?.call(context);
          }
        },
      );

  ListTile toListTile(BuildContext context) => ListTile(
        leading: icon,
        title: Text(name),
        onTap: () {
          if (route != null) {
            Navigator.of(context).pushNamed(route!);
          }
        },
      );
}
