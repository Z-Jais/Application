import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:provider/provider.dart';

class InitializationView extends StatefulWidget {
  const InitializationView({super.key});

  @override
  State<StatefulWidget> createState() => _InitializationViewState();
}

class _InitializationViewState extends State<InitializationView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => AppController.instance.checkInternetConnection());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    info('InitializationView', 'build()');

    return ChangeNotifierProvider.value(
      value: AppController.instance,
      child: Consumer<AppController>(
        builder: (context, value, child) {
          if (value.inProgress) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!value.hasInternet) {
            return Scaffold(
              body: Center(
                child: NoElement(
                  title: AppLocalizations.of(context)!.oops,
                  message:
                      AppLocalizations.of(context)!.connectionFailureMessage,
                  onTap: value.checkInternetConnection,
                ),
              ),
            );
          }

          return FutureBuilder(
            future: value.initialize(context),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
