import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/utils/utils.dart';
import 'package:provider/provider.dart';

class AnimeList extends StatelessWidget {
  final AnimeController controller;

  const AnimeList({required this.controller, super.key});

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
        builder: (_, value, ___) => Column(
          children: value.list,
        ),
      ),
    );
  }
}
