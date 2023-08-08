import 'package:flutter/material.dart';
import 'package:jais/widgets/skeleton.dart';

class SimulcastLoaderWidget extends StatelessWidget {
  const SimulcastLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: const Skeleton(width: 80, height: 20),
    );
  }
}
