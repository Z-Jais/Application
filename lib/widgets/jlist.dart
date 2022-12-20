import 'package:flutter/material.dart';

class JList extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final Axis direction;

  const JList({
    required this.children,
    this.controller,
    this.direction = Axis.vertical,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      controller: controller,
      itemCount: children.length,
      scrollDirection: direction,
      itemBuilder: (_, int index) => children[index],
    );
  }
}
