import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/controllers/datas/int_data_controller.dart';

class AdController {
  static final AdController instance = AdController();

  final IntDataController _adRatio = IntDataController('adRatio');
  bool _initialized = false;
  bool _canWatchAd = true;
  RewardedAd? _ad;
  BannerAd? _bannerAd;

  bool get canWatchAd => _canWatchAd;
  BannerAd? get bannerAd => _bannerAd;

  Future<void> init() async {
    await _adRatio.init();

    await RewardedAd.load(
      adUnitId: 'ca-app-pub-5658764393995798/3650456466',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) async {
          _ad = ad;
          _initialized = true;
          log('Ad loaded');
        },
        onAdFailedToLoad: (LoadAdError error) {
          _initialized = true;
          log('Ad failed to load: $error');
        },
      ),
    );

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-5658764393995798/7021730383',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, _) async {
          ad.dispose();
          _bannerAd = null;
          log('Banner ad failed to load');
        },
      ),
    );

    await _bannerAd?.load();
  }

  Future<void> show(void Function(bool) callback) async {
    // Wait for the ad to be initialized
    while (!_initialized) {
      return;
    }

    if (_ad == null) {
      callback.call(false);
      return;
    }

    _adRatio.data++;
    log('Ad ratio: ${_adRatio.data}');
    final needToShowAd = _adRatio.data % 3 == 0;
    log('Need to show ad: $needToShowAd');

    if (needToShowAd) {
      _adRatio.data = 0;
      log('Reset ad ratio');
    }

    await _adRatio.save();

    if (!needToShowAd) {
      callback.call(false);
      return;
    }

    if (!_canWatchAd) {
      return;
    }

    _canWatchAd = false;

    _ad?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        callback.call(true);
        _canWatchAd = true;
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
      },
    );

    await _ad?.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {},
    );
  }
}
