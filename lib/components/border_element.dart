import 'package:flutter/material.dart';

class BorderElement extends StatelessWidget {
  final Widget? child;

  const BorderElement({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
