import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/mappers/abstract_data.dart';

class DeviceMapper {
  static final DeviceMapper instance = DeviceMapper();

  final DataCollection animeWatchlistData = DataCollection('animeWatchlist');
  BannerAd? globalBannerAd;
  bool _showAds = true;

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
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, _) async {
          ad.dispose();
        },
      ),
    );

    await globalBannerAd?.load();
  }

  Future<void> showVideoAd({void Function(bool)? callback}) async {
    if (!_showAds) {
      return;
    }

    _showAds = false;

    await RewardedAd.load(
      adUnitId: 'ca-app-pub-5658764393995798/3650456466',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) async {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
              callback?.call(true);
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              ad.dispose();
            },
          );

          await ad.show(
            onUserEarnedReward: (_, __) {
              _showAds = true;
            },
          );
        },
        onAdFailedToLoad: (_) {
          callback?.call(false);
          _showAds = true;
        },
      ),
    );
  }
}
