import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/views/home_view.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:provider/provider.dart';

class InitializationView extends StatelessWidget {
  const InitializationView({super.key});

  @override
  Widget build(BuildContext context) {
    info('InitializationView', 'build()');
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
          child: NoElement(
            title: 'Mince !',
            message: 'Impossible de se connecter à Jais !',
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

        return const HomeView();
      },
    );
  }
}
