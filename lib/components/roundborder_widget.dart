import 'package:flutter/material.dart';

class RoundBorderWidget extends StatelessWidget {
  final Widget widget;
  final double radius;

  const RoundBorderWidget({required this.widget, this.radius = 8, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: widget,
    );
  }
}
