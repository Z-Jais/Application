import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/ads/banner_ad.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/mappers/display_mapper.dart';

class Navbar extends StatelessWidget {
  final Function(int)? onPageChanged;
  final Iterable<Widget>? webWidgets;

  const Navbar({
    this.onPageChanged,
    this.webWidgets,
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
            child: globalBannerAd != null
                ? AdWidget(ad: globalBannerAd!)
                : ColoredBox(color: Theme.of(context).backgroundColor),
          ),
          if (kIsWeb &&
              !DisplayMapper.isOnMobile(context) &&
              webWidgets != null) ...<Widget>[
            const SizedBox(width: 10),
            ...webWidgets!
          ]
        ],
      ),
    );
  }
}
