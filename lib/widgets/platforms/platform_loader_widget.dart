import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/skeleton.dart';

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
