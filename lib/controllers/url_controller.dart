import 'dart:convert';
import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AdController {
  static final AdController instance = AdController();

  bool _initialized = false;
  bool _canWatchAd = true;
  RewardedAd? _ad;

  bool get canWatchAd => _canWatchAd;

  Future<void> init() async {
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
          _initialized = false;
          log('Ad failed to load: $error');
        },
      ),
    );
  }

  Future<void> show({void Function(bool)? callback}) async {
    // Wait for the ad to be initialized
    while (!_initialized) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (_ad == null) {
      callback?.call(false);
      return;
    }

    if (!_canWatchAd) {
      return;
    }

    _canWatchAd = false;

    _ad?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        callback?.call(true);
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

class URLController {
  Future<http.Response?> get(String url) async {
    try {
      return http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
    } catch (_) {
      return null;
    }
  }

  Future<http.Response?> post(String url, {Object? body}) async {
    try {
      return await http
          .post(Uri.parse(url), body: body)
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      return null;
    }
  }

  Future<void> goOnUrl(String url, {bool showAd = true}) async {
    Future<bool> redirectTo() async {
      return launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }

    if (showAd) {
      await AdController.instance.show(callback: (_) async => redirectTo());
    } else {
      await redirectTo();
    }
  }
}

extension ResponseNullableExtension on http.Response? {
  bool get isOk => this != null && this?.statusCode == 200;

  bool isCorrect(int statusCode) =>
      this != null && this?.statusCode == statusCode;

  T ifOk<T>(T Function(http.Response) map) {
    if (isOk) {
      return map(this!);
    } else {
      throw Exception('Response is not ok');
    }
  }
}

extension ResponseExtension on http.Response {
  dynamic get toJson => jsonDecode(utf8.decode(bodyBytes));

  List<dynamic> get toJsonList => toJson as List<dynamic>;

  List<Map<String, dynamic>> get toJsonMapList =>
      toJsonList.map((e) => e as Map<String, dynamic>).toList();
}

extension FutureResponseNullableExtension on Future<http.Response?> {
  Future<T> ifOk<T>(T Function(http.Response) map) async {
    final http.Response? response = await this;

    if (response.isOk) {
      return map(response!);
    } else {
      throw Exception('Response is not ok');
    }
  }

  Future<List<T>> mapWithObjectIfOk<T>(
    T Function(Map<String, dynamic>) map,
  ) async =>
      ifOk((response) => response.toJsonMapList.map(map).toList());
}
