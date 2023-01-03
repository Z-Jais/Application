import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      height: 40,
      child: Row(
        children: <Widget>[
          RoundBorderDecoration(widget: Image.asset('assets/icon.png')),
          const SizedBox(width: 10),
          Text(
            'Jaïs',
            style: GoogleFonts.pacifico(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
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
