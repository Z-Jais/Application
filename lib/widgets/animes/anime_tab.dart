import 'package:flutter/material.dart';
import 'package:jais/controllers/anime_tab_controller.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/simulcasts/simulcast_list.dart';

class AnimeTab extends StatelessWidget {
  final AnimeTabController controller;

  const AnimeTab({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.init(),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          controller: controller.animeController.scrollController,
          child: Column(
            children: <Widget>[
              SimulcastList(
                simulcastController: controller.simulcastController,
                animeController: controller.animeController,
              ),
              AnimeList(
                controller: controller.animeController,
                listView: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
