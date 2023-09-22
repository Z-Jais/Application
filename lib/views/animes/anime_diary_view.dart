import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_diary_controller.dart';
import 'package:jais/widgets/day_widget.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:provider/provider.dart';

class AnimeCalendarView extends StatelessWidget {
  final AnimeCalendarController controller;

  const AnimeCalendarView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendrier'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ChangeNotifierProvider.value(
                value: controller,
                child: Consumer<AnimeCalendarController>(
                  builder: (_, value, ___) {
                    return HVList(
                      hController: value.scrollController,
                      hList: controller.days.map(
                        (DayWidget e) => GestureDetector(
                          child: e,
                          onTap: () async => controller.day = e.dayNumber,
                        ),
                      ),
                      hCenter: true,
                      vList: value.list,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
