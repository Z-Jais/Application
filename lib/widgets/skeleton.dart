import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double? width;
  final double? height;

  const Skeleton({this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.black,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.09),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}
