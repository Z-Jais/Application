import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jais/controllers/episode_controller.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/widgets/infinite_scroll.dart';

class EpisodeList2 extends StatelessWidget {
  final EpisodeController episodeController;

  const EpisodeList2({required this.episodeController, super.key});

  Future<void> reset() async {
    episodeController.reset();
    episodeController.load();
  }

  @override
  Widget build(BuildContext context) {
    if (!DeviceMapper.instance.isOnMobile(context)) {
      final double width = MediaQuery.of(context).size.width;

      return RefreshIndicator(
        onRefresh: reset,
        child: InfiniteScroll(
          controller: episodeController,
          builder: () => GridView(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: -1.92 + 0.42 * log(width),
            ),
            controller: episodeController.scrollController,
            children: episodeController.list,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: reset,
      child: InfiniteScroll(
        controller: episodeController,
        builder: () => ListView.builder(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          controller: episodeController.scrollController,
          itemCount: episodeController.list.length,
          itemBuilder: (_, int index) => episodeController.list[index],
        ),
      ),
    );
  }
}


