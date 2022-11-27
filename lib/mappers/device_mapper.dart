import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceMapper {
  static final ReviewMapper reviewMapper = ReviewMapper();
  static final AbstractCollection animeWatchlistData =
      AbstractCollection('animeWatchlist');
  static final AbstractCollection mangaWatchlistData =
      AbstractCollection('mangaWatchlist');
  static final AbstractData recommendedAnimeData =
      AbstractData('recommendedAnime');
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

class AbstractCollection {
  final String key;
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  AbstractCollection(this.key);

  Future<List<String>> load() async =>
      (await _sharedPreferences).getStringList(key) ?? <String>[];

  Future<void> save(List<String> data) async =>
      (await _sharedPreferences).setStringList(key, data);

  Future<String> toGzip() async =>
      base64Encode(gzip.encode(utf8.encode(jsonEncode(await load()))));

  bool hasIn(List<String> list, String uuid) => list.contains(uuid);

  Future<bool> has(String uuid) async => hasIn(await load(), uuid);

  Future<void> add(String uuid) async {
    final List<String> watchlist = await load();

    if (hasIn(watchlist, uuid)) {
      return;
    }

    watchlist.add(uuid);
    await save(watchlist);
  }

  Future<void> addAll(Iterable<String> uuids) async {
    final List<String> watchlist = await load();

    for (final String uuid in uuids) {
      if (hasIn(watchlist, uuid)) {
        continue;
      }

      watchlist.add(uuid);
    }

    await save(watchlist);
  }

  Future<void> remove(String uuid) async {
    final List<String> watchlist = await load();

    if (!hasIn(watchlist, uuid)) {
      return;
    }

    watchlist.remove(uuid);
    await save(watchlist);
  }
}

class AbstractData {
  final String key;
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  AbstractData(this.key);

  Future<Map<String, dynamic>> load() async {
    final String? data = (await _sharedPreferences).getString(key);

    if (data == null) {
      return <String, dynamic>{};
    }

    return jsonDecode(data);
  }

  Future<void> save(Map<String, dynamic> data) async =>
      (await _sharedPreferences).setString(key, jsonEncode(data));

  Future<bool> has(String key) async => (await load()).containsKey(key);

  Future<dynamic> get(String key) async => (await load())[key];

  Future<void> add(String key, dynamic value) async {
    final Map<String, dynamic> data = await load();
    data[key] = value;
    await save(data);
  }

  Future<void> remove(String key) async {
    final Map<String, dynamic> data = await load();
    data.remove(key);
    await save(data);
  }

  Future<int> count(dynamic value) async {
    final Map<String, dynamic> data = await load();
    return data.values.where((dynamic element) => element == value).length;
  }
}
