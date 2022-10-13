import 'package:flutter/material.dart';

class SimulcastList extends StatelessWidget {
  final ScrollController? scrollController;
  final Iterable<Widget> children;

  const SimulcastList({
    required this.children,
    this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[...children],
      ),
    );
  }
}
