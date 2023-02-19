import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/controllers/ad_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/navigation_controller.dart';
import 'package:jais/models/navigation_bar_item.dart';
import 'package:jais/widgets/decoration/round_border_decoration.dart';
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
    return SizedBox(
      height: 50,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Développé par :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('• Ziedelth'),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Text(
                        'Partenariat :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('• Kitsune No Baguette'),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Text(
                        'Contributeur :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('• SputNikPlop'),
                    ],
                  ),
                ),
              );
            },
            child:
                RoundBorderDecoration(widget: Image.asset('assets/icon.png')),
          ),
          const SizedBox(width: 5),
          Text(
            'Jaïs',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontFamily: 'Pacifico',
            ),
          ),
          if (AdController.instance.bannerAd != null &&
              AppController.isAndroidOrIOS)
            Expanded(
              child: ColoredBox(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AdWidget(
                    ad: AdController.instance.bannerAd!,
                  ),
                ),
              ),
            )
          else
            const Spacer(),
          ChangeNotifierProvider.value(
            value: NavigationController.instance,
            child: Consumer<NavigationController>(
              builder: (context, value, _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...?calculateTopWidgets(
                      context,
                      value.currentTopNavigationBarItems,
                    )
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
