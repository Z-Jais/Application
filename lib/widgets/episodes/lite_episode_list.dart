import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/infinite_scroll.dart';

class LiteEpisodeList extends StatelessWidget {
  final AnimeDetailController controller;

  const LiteEpisodeList({required this.controller, super.key});

  Future<void> reset() async {
    controller.reset();
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    if (!context.isOnMobile) {
      return InfiniteScroll(
        controller: controller,
        builder: () => SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: Utils.instance.separate(controller.list),
          ),
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
