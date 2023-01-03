import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/simulcast_controller.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';
import 'package:provider/provider.dart';

class SimulcastList extends StatelessWidget {
  final SimulcastController simulcastController;
  final AnimeController animeController;

  const SimulcastList({
    required this.simulcastController,
    required this.animeController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log('SimulcastList.build()');

    return SingleChildScrollView(
      controller: simulcastController.scrollController,
      scrollDirection: Axis.horizontal,
      child: ChangeNotifierProvider.value(
        value: simulcastController,
        child: Consumer<SimulcastController>(
          builder: (_, value, __) => Row(
            children: [
              ...value.setCurrent(animeController.simulcast).map(
                    (e) => GestureDetector(
                      child: e,
                      onTap: () {
                        if (e is! SimulcastWidget) {
                          return;
                        }

                        animeController.scrollController.jumpTo(0);
                        animeController.simulcast = e.simulcast;
                        animeController.reset();
                        animeController.load();
                        value.notify();
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
