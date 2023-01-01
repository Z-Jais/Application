import 'package:flutter/material.dart';

class DeviceController {
  static DeviceController instance = DeviceController();

  bool isOnMobile(BuildContext context, [double width = 600]) {
    return MediaQuery.of(context).size.width < width;
  }
}
