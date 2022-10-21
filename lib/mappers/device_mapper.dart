import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceMapper {
  static final ReviewMapper reviewMapper = ReviewMapper();

  static bool isOnMobile(BuildContext context, [double width = 600]) {
    return MediaQuery.of(context).size.width < width;
  }

  @pragma('vm:entry-point')
  static Future<String?> getId() async {
    return PlatformDeviceId.getDeviceId;
  }

  @pragma('vm:entry-point')
  static Future<String> getOS() async {
    final AndroidDeviceInfo androidDeviceInfo =
        await DeviceInfoPlugin().androidInfo;
    return 'Android ${androidDeviceInfo.version.release}';
  }

  @pragma('vm:entry-point')
  static Future<String> getModel() async {
    final AndroidDeviceInfo androidDeviceInfo =
        await DeviceInfoPlugin().androidInfo;
    return '${androidDeviceInfo.manufacturer} ${androidDeviceInfo.model}';
  }

  static Future<void> updateOriginDevice() async {
    await URL().post(
      UrlConst.devices,
      body: jsonEncode(<String, dynamic>{
        'name': await getId(),
        'os': await getOS(),
        'model': await getModel(),
      }),
    );
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
