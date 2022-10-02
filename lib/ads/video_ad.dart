import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

bool _showAds = true;

Future<void> showVideoAd({VoidCallback? callback}) async {
  if (!_showAds) {
    return;
  }

  _showAds = false;

  await RewardedAd.load(
    adUnitId: 'ca-app-pub-5658764393995798/3650456466',
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (RewardedAd ad) {
        ad.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            callback?.call();
            _showAds = true;
          },
        );
      },
      onAdFailedToLoad: (LoadAdError error) {
        _showAds = true;
      },
    ),
  );
}
