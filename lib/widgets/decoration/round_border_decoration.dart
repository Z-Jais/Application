import 'package:flutter/material.dart';

class RoundBorderDecoration extends StatelessWidget {
  final Widget widget;
  final double radius;

  const RoundBorderDecoration({required this.widget, this.radius = 8, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: widget,
    );
  }
}
