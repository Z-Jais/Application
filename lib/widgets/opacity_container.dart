import 'package:flutter/material.dart';

class OpacityContainer extends StatelessWidget {
  final String? text;
  final Widget? child;

  const OpacityContainer({this.text, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2.5,
        horizontal: 10,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color.fromRGBO(0, 0, 0, 0.75),
      ),
      child: text != null
          ? Text(
              text!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : child,
    );
  }
}
