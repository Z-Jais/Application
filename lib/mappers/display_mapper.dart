import 'package:flutter/material.dart';

class DisplayMapper {
  static bool isOnMobile(BuildContext context, [double width = 600]) {
    return MediaQuery.of(context).size.width < width;
  }
}
