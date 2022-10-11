import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jais/components/jlist.dart';
import 'package:jais/mappers/display_mapper.dart';

class EpisodeList extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Widget> children;

  const EpisodeList({required this.children, this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    if (!DisplayMapper.isOnMobile(context)) {
      final double width = MediaQuery.of(context).size.width;

      return GridView(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: -1.92 + 0.42 * log(width),
        ),
        controller: scrollController,
        children: <Widget>[...children],
      );
    }

    return JList(
      controller: scrollController,
      children: <Widget>[...children],
    );
  }
}
