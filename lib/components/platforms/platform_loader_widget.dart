import 'package:flutter/material.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/utils/const.dart';

class PlatformLoaderWidget extends StatelessWidget {
  const PlatformLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeleton(
      width: Const.platformImageWith,
      height: Const.platformImageHeight,
    );
  }
}
