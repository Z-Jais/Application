import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/widgets/jlist.dart';

class EpisodeList extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Widget> children;

  const EpisodeList({required this.children, this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    if (!DeviceMapper.instance.isOnMobile(context)) {
      final double width = MediaQuery.of(context).size.width;

      return GridView(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: -1.92 + 0.42 * log(width),
        ),
        controller: scrollController,
        children: children,
      );
    }

    return JList(
      controller: scrollController,
      children: children,
    );
  }
}
