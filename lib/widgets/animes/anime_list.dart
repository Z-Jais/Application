import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:provider/provider.dart';

class AnimeList extends StatelessWidget {
  final AnimeController controller;
  final bool listView;

  const AnimeList({required this.controller, this.listView = true, super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.isOnMobile) {
      return ChangeNotifierProvider.value(
        value: controller,
        child: Consumer<AnimeController>(
          builder: (_, value, ___) => (value.nothingToShow() ||
                  (controller is AnimeDiaryController && value.list.isEmpty))
              ? const NoElement()
              : listView
                  ? SingleChildScrollView(
                      child: Column(
                        children: Utils.instance.separate(value.list),
                      ),
                    )
                  : Column(
                      children: Utils.instance.separate(value.list),
                    ),
        ),
      );
    }

    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<AnimeController>(
        builder: (_, value, ___) => (value.nothingToShow() ||
                (controller is AnimeDiaryController && value.list.isEmpty))
            ? const NoElement()
            : listView
                ? ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    controller: value.scrollController,
                    itemCount: value.list.length,
                    itemBuilder: (_, int index) => value.list[index],
                  )
                : Column(
                    children: value.list,
                  ),
      ),
    );
  }
}
