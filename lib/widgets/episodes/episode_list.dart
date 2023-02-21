import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/infinite_scroll.dart';

class EpisodeList extends StatelessWidget {
  final EpisodeController controller;

  const EpisodeList({required this.controller, super.key});

  Future<void> reset() async {
    controller.reset();
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    log('EpisodeList', 'build()');

    if (!context.isOnMobile) {
      final double width = MediaQuery.of(context).size.width;

      return InfiniteScroll(
        controller: controller,
        builder: () => GridView(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: -1.92 + 0.42 * math.log(width),
          ),
          controller: controller.scrollController,
          children: [...controller.list],
        ),
      );
    }

    return InfiniteScroll(
      controller: controller,
      builder: () => ListView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        controller: controller.scrollController,
        itemCount: controller.list.length,
        itemBuilder: (_, int index) => controller.list[index],
      ),
    );
  }
}
