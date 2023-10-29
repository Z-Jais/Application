import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_calendar_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/day_widget.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:provider/provider.dart';

class AnimeCalendarView extends StatefulWidget {
  final AnimeCalendarController controller;

  const AnimeCalendarView({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _AnimeCalendarViewState();
}

class _AnimeCalendarViewState extends State<AnimeCalendarView> {
  double _map(
    double x,
    double inMin,
    double inMax,
    double outMin,
    double outMax,
  ) {
    return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final max = widget.controller.scrollController.position.maxScrollExtent;
      final position = _map(widget.controller.day / 7.0, 0, 1, 0, max);
      widget.controller.scrollController.scrollTo(position);
    });

    super.initState();
  }

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
                value: widget.controller,
                child: Consumer<AnimeCalendarController>(
                  builder: (_, value, ___) {
                    return HVList(
                      hController: value.scrollController,
                      hList: value.days
                          .map(
                            (DayWidget e) => GestureDetector(
                              child: e,
                              onTap: () async => value.day = e.dayNumber,
                            ),
                          )
                          .toList(),
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
