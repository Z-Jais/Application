import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/components/no_connection.dart';
import 'package:jais/controllers/initialization_controller.dart';
import 'package:jais/controllers/network_controller.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/views/home_view.dart';
import 'package:provider/provider.dart';

class InitializationView extends StatelessWidget {
  final InitializationController controller;

  const InitializationView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    log('InitializationView.build()');
    final networkController = Provider.of<NetworkController>(context);

    if (networkController.inProgress) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!networkController.hasInternet) {
      return Scaffold(
        body: Center(
          child: NoConnection(
            onRetry: networkController.checkInternetConnection,
          ),
        ),
      );
    }

    return FutureBuilder(
      future: controller.initialize(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: const HomeView(),
            bottomNavigationBar: ChangeNotifierProvider<NavbarMapper>.value(
              value: NavbarMapper.instance,
              child: Consumer<NavbarMapper>(
                builder: (_, value, __) {
                  return BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Colors.grey,
                    currentIndex: value.currentPage,
                    onTap: (page) => value.changePage(page, fromNavBar: true),
                    items: [...value.itemsBottomNavBar(context)],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
