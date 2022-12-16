import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/mappers/abstract_data.dart';

class DeviceMapper {
  static final DeviceMapper instance = DeviceMapper();

  final DataCollection animeWatchlistData = DataCollection('animeWatchlist');
  final DataCollection mangaWatchlistData = DataCollection('mangaWatchlist');
  final DataMap recommendedAnimeData = DataMap('recommendedAnime');
  BannerAd? globalBannerAd;

  bool isOnMobile(BuildContext context, [double width = 600]) {
    return MediaQuery.of(context).size.width < width;
  }

  Future<void> createGlobalBanner() async {
    if (globalBannerAd != null) {
      await globalBannerAd?.load();
      return;
    }

    globalBannerAd = BannerAd(
      adUnitId: 'ca-app-pub-5658764393995798/7021730383',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, _) async {
          ad.dispose();
        },
      ),
    );

    await globalBannerAd?.load();
  }
}
