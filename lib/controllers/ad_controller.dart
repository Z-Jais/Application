import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends ChangeNotifier {
  static AdController instance = AdController();

  final _adUnitId = 'ca-app-pub-5658764393995798/7021730383';
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  BannerAd? get bannerAd => _bannerAd;
  bool get isLoaded => _isLoaded;

  Future<void> loadAd() async {
    _bannerAd = BannerAd(
      adUnitId: _adUnitId,
      request: const AdManagerAdRequest(),
      size: AdSize.banner,
      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) {
          _isLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          _isLoaded = false;
          ad.dispose();
        },
      ),
    );

    await _bannerAd?.load();
  }
}
