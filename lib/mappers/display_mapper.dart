import 'package:flutter/material.dart';

class DisplayMapper {
  static bool isOnMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
}
