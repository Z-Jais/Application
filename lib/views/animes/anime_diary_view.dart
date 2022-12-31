import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/day_widget.dart';
import 'package:provider/provider.dart';

class AnimeDiaryView extends StatelessWidget {
  final AnimeDiaryController controller;

  const AnimeDiaryView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agenda'),
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ChangeNotifierProvider.value(
                value: controller,
                child: Consumer<AnimeDiaryController>(
                  builder: (_, value, ___) => Row(
                    children: [
                      ...controller.days.map(
                        (DayWidget e) => GestureDetector(
                          child: e,
                          onTap: () async => controller.day = e.dayNumber,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: AnimeList(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}
