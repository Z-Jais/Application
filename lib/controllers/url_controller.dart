import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jais/controllers/ad_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<bool> _redirectTo(String url) async {
    return launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> goOnUrl(String url, {bool showAd = true}) async {
    if (showAd && AppController.isAndroidOrIOS) {
      await AdController.instance.show(callback: (_) async => _redirectTo(url));
    } else {
      await _redirectTo(url);
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
