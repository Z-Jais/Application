import 'package:flutter/material.dart';
import 'package:jais/mappers/display_mapper.dart';

class AnimeList extends StatelessWidget {
  final List<Widget> children;

  const AnimeList({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    if (!DisplayMapper.isOnMobile(context)) {
      final List<Widget> columnChildren = <Widget>[];

      for (int i = 0; i < children.length; i += 3) {
        final List<Widget> subChildren = children.sublist(i, i + 3);
        columnChildren.add(
          Row(
            children: subChildren
                .map<Widget>(
                  (Widget e) => Expanded(child: e),
                )
                .toList(),
          ),
        );
      }

      return Column(
        children: columnChildren,
      );
    }

    return Column(children: children);
  }
}
