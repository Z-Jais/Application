import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/views/home_view.dart';
import 'package:jais/widgets/jnavigation_bar.dart';
import 'package:jais/widgets/no_connection.dart';
import 'package:provider/provider.dart';

class InitializationView extends StatelessWidget {
  const InitializationView({super.key});

  @override
  Widget build(BuildContext context) {
    log('InitializationView.build()');
    final appController = Provider.of<AppController>(context);

    if (appController.inProgress) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!appController.hasInternet) {
      return Scaffold(
        body: Center(
          child: NoConnection(
            onRetry: appController.checkInternetConnection,
          ),
        ),
      );
    }

    return FutureBuilder(
      future: appController.initialize(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return const SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: HomeView(),
            bottomNavigationBar: JNavigationBar(),
          ),
        );
      },
    );
  }
}
