import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:provider/provider.dart';

class JNavigationBar extends StatelessWidget {
  const JNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    log('JNavigationBar.build()');

    return ChangeNotifierProvider.value(
      value: NavigationController.instance,
      child: Consumer<NavigationController>(
        builder: (_, value, __) {
          return BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            currentIndex: value.currentPage,
            onTap: (page) =>
                value.setCurrentPage(page, fromNavigationBar: true),
            items: value.bottomNavigationBarItems.toList(),
          );
        },
      ),
    );
  }
}
