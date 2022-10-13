import 'package:flutter/material.dart';
import 'package:jais/components/jlist.dart';

class LiteEpisodeList extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Widget> children;

  const LiteEpisodeList({
    required this.children,
    this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return JList(
      controller: scrollController,
      children: <Widget>[...children],
    );
  }
}
