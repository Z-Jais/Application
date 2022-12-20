import 'package:flutter/material.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/utils/utils.dart';
import 'package:jais/widgets/jlist.dart';

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
    if (!DeviceMapper.instance.isOnMobile(context)) {
      return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: Utils.instance.separate(children),
        ),
      );
    }

    return JList(
      controller: scrollController,
      children: children,
    );
  }
}
