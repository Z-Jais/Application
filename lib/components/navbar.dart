import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/navbar_mapper.dart';

class Navbar extends StatelessWidget {
  final Function(int)? onPageChanged;
  final Iterable<NavbarLink>? topWidgets;
  final Future<void> _adFuture = DeviceMapper.createGlobalBanner();

  Navbar({
    this.onPageChanged,
    this.topWidgets,
    super.key,
  });

  Iterable<Widget>? get calculcateTopWidgets {
    if (topWidgets == null || topWidgets!.isEmpty) {
      return null;
    }

    final int length = topWidgets!.length;

    if (length > 2) {
      return <Widget>[
        topWidgets!.first.toIconButton,
        PopupMenuButton<int>(
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<int>>[
              for (int i = 1; i < length; i++)
                PopupMenuItem<int>(
                  value: i - 1,
                  child: topWidgets!.elementAt(i).toListTile,
                ),
            ];
          },
        ),
      ];
    }

    return topWidgets!.map((NavbarLink navbarLink) => navbarLink.toIconButton);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            RoundBorderWidget(widget: Image.asset('assets/icon.png')),
            const SizedBox(width: 10),
            Text(
              'Jaïs',
              style: GoogleFonts.pacifico(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FutureBuilder<void>(
                future: _adFuture,
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AdWidget(
                      ad: DeviceMapper.globalBannerAd!,
                    );
                  }

                  return const ColoredBox(color: Colors.transparent);
                },
              ),
            ),
            ...?calculcateTopWidgets,
          ],
        ),
      ),
    );
  }
}
