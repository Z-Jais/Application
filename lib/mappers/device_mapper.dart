import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jais/mappers/abstract_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceMapper {
  static final DeviceMapper instance = DeviceMapper();

  final ReviewMapper reviewMapper = ReviewMapper();
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

  Future<bool> hasInternet() async {
    final InternetConnectionChecker customInstance =
        InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(milliseconds: 2500),
      checkInterval: const Duration(seconds: 1),
    );

    return customInstance.hasConnection;
  }
}

class ReviewMapper {
  Future<bool> canShowReview() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String reviewType = prefs.getString('reviewType') ?? 'pending';

    if (reviewType == 'never' || reviewType == 'accepted') {
      return false;
    }

    final int reviewCount = ((prefs.getInt('reviewCount') ?? 0) + 1) % 5;
    await prefs.setInt('reviewCount', reviewCount);
    return reviewCount == 0 && (await InAppReview.instance.isAvailable());
  }

  Future<void> acceptReview() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('reviewType', 'accepted');
  }

  Future<void> neverReview() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('reviewType', 'never');
  }
}
