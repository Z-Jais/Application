import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/utils/utils.dart';
import 'package:provider/provider.dart';

class AnimeList extends StatelessWidget {
  final AnimeController controller;
  final bool listView;

  const AnimeList({required this.controller, this.listView = true, super.key});

  @override
  Widget build(BuildContext context) {
    if (!DeviceMapper.instance.isOnMobile(context)) {
      return ChangeNotifierProvider.value(
        value: controller,
        child: Consumer<AnimeController>(
          builder: (_, value, ___) => Column(
            children: Utils.instance.separate(value.list),
          ),
        ),
      );
    }

    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<AnimeController>(
        builder: (_, value, ___) => listView
            ? ListView.builder(
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                controller: controller.scrollController,
                itemCount: controller.list.length,
                itemBuilder: (_, int index) => controller.list[index],
              )
            : Column(
                children: value.list,
              ),
      ),
    );
  }
}
