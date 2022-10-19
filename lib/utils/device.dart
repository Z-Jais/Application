import 'package:device_info_plus/device_info_plus.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';

class Device {
  @pragma('vm:entry-point')
  static Future<String?> getId() async {
    return PlatformDeviceId.getDeviceId;
  }

  @pragma('vm:entry-point')
  static Future<String> getOS() async {
    final AndroidDeviceInfo androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    return 'Android ${androidDeviceInfo.version.release}';
  }

  @pragma('vm:entry-point')
  static Future<String> getModel() async {
    final AndroidDeviceInfo androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    return '${androidDeviceInfo.manufacturer} ${androidDeviceInfo.model}';
  }
}