import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/ads/banner_ad.dart';
import 'package:jais/components/roundborder_widget.dart';

class Navbar extends StatelessWidget {
  final Function(int)? onPageChanged;
  final Iterable<Widget>? topWidgets;
  final Future<void> _adFuture = createGlobalBanner();

  Navbar({
    this.onPageChanged,
    this.topWidgets,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
              builder: (_, AsyncSnapshot<void> snapshot) {
                if (snapshot.hasData) {
                  return AdWidget(ad: globalBannerAd!);
                }

                return ColoredBox(color: Theme.of(context).backgroundColor);
              },
            ),
          ),
          ...?topWidgets,
        ],
      ),
    );
  }
}
