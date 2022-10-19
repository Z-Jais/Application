import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';

class DeviceMapper {
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

  static Future<void> createEpisodeRedirection(Episode episode) async {
    await URL().post(
      UrlConst.devicesEpisodeRedirection,
      headers: <String, String>{
        'Device': await getId() ?? '',
        'Episode': episode.uuid,
      },
    );
  }
}
