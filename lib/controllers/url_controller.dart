import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jais/controllers/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class URLController {
  static const Duration _timeoutDuration = Duration(seconds: 10);

  Future<http.Response?> get(String url) async {
    try {
      debug('URLController', 'get($url)');
      final http.Response response =
          await http.get(Uri.parse(url)).timeout(_timeoutDuration);
      debug('URLController', 'get($url) => $response');
      return response;
    } catch (exception, stackTrace) {
      error('URLController', 'get()', exception, stackTrace);
      return null;
    }
  }

  Future<http.Response?> post(String url, Object body) async {
    try {
      debug('URLController', 'post($url, $body)');
      final http.Response response =
          await http.post(Uri.parse(url), body: body).timeout(_timeoutDuration);
      debug('URLController', 'post($url, $body) => $response');
      return response;
    } catch (exception, stackTrace) {
      error('URLController', 'post()', exception, stackTrace);
      return null;
    }
  }

  Future<bool> _redirectTo(String url) async {
    return launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> goOnUrl(String url) async {
    await _redirectTo(url);
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
      throw Exception(
        'Response is not ok (${response?.statusCode} - ${response?.body})',
      );
    }
  }

  Future<List<T>> mapWithObjectIfOk<T>(
    T Function(Map<String, dynamic>) map,
  ) async =>
      ifOk((response) => response.toJsonMapList.map(map).toList());
}
