import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceMapper {
  static final ReviewMapper reviewMapper = ReviewMapper();
  static final DataCollection animeWatchlistData =
      DataCollection('animeWatchlist');
  static final DataCollection mangaWatchlistData =
      DataCollection('mangaWatchlist');
  static BannerAd? globalBannerAd;

  static bool isOnMobile(BuildContext context, [double width = 600]) {
    return MediaQuery.of(context).size.width < width;
  }

  static Future<void> createGlobalBanner() async {
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

    globalBannerAd?.load();
  }

  static Future<bool> hasInternet() async {
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

class DataCollection {
  final String key;
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  DataCollection(this.key);

  Future<List<String>> get() async =>
      (await _sharedPreferences).getStringList(key) ?? <String>[];

  Future<String> toGzip() async =>
      base64Encode(gzip.encode(utf8.encode(jsonEncode(await get()))));

  bool hasIn(List<String> list, String uuid) => list.contains(uuid);

  Future<bool> has(String uuid) async => hasIn(await get(), uuid);

  Future<void> add(String uuid) async {
    final List<String> watchlist = await get();

    if (hasIn(watchlist, uuid)) {
      return;
    }

    watchlist.add(uuid);
    await (await _sharedPreferences).setStringList(key, watchlist);
  }

  Future<void> addAll(Iterable<String> uuids) async {
    final List<String> watchlist = await get();

    for (final String uuid in uuids) {
      if (hasIn(watchlist, uuid)) {
        continue;
      }

      watchlist.add(uuid);
    }

    await (await _sharedPreferences).setStringList(key, watchlist);
  }

  Future<void> remove(String uuid) async {
    final List<String> watchlist = await get();

    if (!hasIn(watchlist, uuid)) {
      return;
    }

    watchlist.remove(uuid);
    await (await _sharedPreferences).setStringList(key, watchlist);
  }
}
