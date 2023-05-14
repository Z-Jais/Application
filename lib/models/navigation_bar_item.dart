import 'package:flutter/material.dart';

class NavigationBarItem {
  final String name;
  final Icon? selectedIcon;
  final Icon icon;
  final List<NavigationBarItem>? topWidgets;
  final String? route;
  final void Function(BuildContext)? onPressed;

  const NavigationBarItem({
    required this.name,
    this.selectedIcon,
    required this.icon,
    this.topWidgets,
    this.route,
    this.onPressed,
  });

  NavigationDestination toNavigationDestination() => NavigationDestination(
        icon: icon,
        selectedIcon: selectedIcon,
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
