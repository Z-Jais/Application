import 'package:http/http.dart' as http;
import 'package:jais/ads/video_ad.dart';
import 'package:url_launcher/url_launcher.dart';

extension UrlExtension on http.Response? {
  bool get isOk => this != null && this?.statusCode == 200;

  bool isCorrect(int statusCode) =>
      this != null && this?.statusCode == statusCode;
}

class URL {
  Future<http.Response?> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      return null;
    }
  }

  Future<http.Response?> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      return await http
          .post(Uri.parse(url), headers: headers, body: body)
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      return null;
    }
  }

  Future<http.Response?> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      return await http
          .put(Uri.parse(url), headers: headers, body: body)
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      return null;
    }
  }

  static Future<void> goOnUrl(String url, {bool showAd = true}) async {
    Future<bool> redirectToEpisode() async {
      return launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }

    if (showAd) {
      showVideoAd(
        callback: (_) async => redirectToEpisode(),
      );
    } else {
      await redirectToEpisode();
    }
  }
}
