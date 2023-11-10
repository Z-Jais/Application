import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/controllers/ad_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:jais/models/navigation_bar_item.dart';
import 'package:provider/provider.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});

  Iterable<Widget>? calculateTopWidgets(
    BuildContext context,
    Iterable<NavigationBarItem>? topWidgets,
  ) {
    if (topWidgets == null || topWidgets.isEmpty) {
      return null;
    }

    final int length = topWidgets.length;

    if (length > 2) {
      return <Widget>[
        topWidgets.first.toIconButton(context),
        PopupMenuButton<int>(
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<int>>[
              for (int i = 1; i < length; i++)
                PopupMenuItem<int>(
                  value: i - 1,
                  child: topWidgets.elementAt(i).toListTile(context),
                ),
            ];
          },
        ),
      ];
    }

    return topWidgets.map(
      (NavigationBarItem navigationBarItem) =>
          navigationBarItem.toIconButton(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    info('TopNavigationBar', 'build()');

    return SizedBox(
      height: 50,
      child: Row(
        children: <Widget>[
          const Image(image: AssetImage('assets/icon.png')),
          ChangeNotifierProvider.value(
            value: AdController.instance,
            child: Consumer<AdController>(
              builder: (context, value, child) {
                if (!value.isLoaded) {
                  return const Spacer();
                }

                return Expanded(child: AdWidget(ad: value.bannerAd!));
              },
            ),
          ),
          ChangeNotifierProvider.value(
            value: NavigationController.instance,
            child: Consumer<NavigationController>(
              builder: (context, value, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...?calculateTopWidgets(
                      context,
                      value.currentTopNavigationBarItems(context),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
