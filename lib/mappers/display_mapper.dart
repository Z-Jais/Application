import 'package:flutter/material.dart';

class DisplayMapper {
  static bool isOnMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
}
