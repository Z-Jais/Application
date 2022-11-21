import 'package:flutter/material.dart';
import 'package:jais/components/jlist.dart';
import 'package:jais/mappers/device_mapper.dart';

class MangaList extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Widget> children;

  const MangaList({required this.children, super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    if (!DeviceMapper.isOnMobile(context)) {
      final double width = MediaQuery.of(context).size.width;

      return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.28E-3 * width + 0.0772,
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
