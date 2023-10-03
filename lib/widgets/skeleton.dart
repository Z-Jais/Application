import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;

  const Skeleton({
    this.width,
    required this.height,
    this.radius = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFFFFFFF),
      highlightColor: const Color(0xFF000000),
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.1),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
      ),
    );
  }
}
