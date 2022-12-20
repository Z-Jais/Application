import 'package:flutter/material.dart';
import 'package:jais/mappers/animes/anime_mapper.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/animes/anime_widget.dart';
import 'package:jais/widgets/infinite_scroll.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:jais/widgets/text_border.dart';

class AnimeDiaryView extends StatefulWidget {
  const AnimeDiaryView({super.key});

  @override
  State<AnimeDiaryView> createState() => _AnimeDiaryViewState();
}

class _AnimeDiaryViewState extends State<AnimeDiaryView> {
  final AnimeMapper _animeMapper = AnimeMapper(listener: false);
  final List<DayWidget> _initial = const <DayWidget>[
    DayWidget(
      day: 'Lundi',
      dayNumber: 1,
    ),
    DayWidget(
      day: 'Mardi',
      dayNumber: 2,
    ),
    DayWidget(
      day: 'Mercredi',
      dayNumber: 3,
    ),
    DayWidget(
      day: 'Jeudi',
      dayNumber: 4,
    ),
    DayWidget(
      day: 'Vendredi',
      dayNumber: 5,
    ),
    DayWidget(
      day: 'Samedi',
      dayNumber: 6,
    ),
    DayWidget(
      day: 'Dimanche',
    ),
  ];
  final List<DayWidget> _days = <DayWidget>[];

  Future<void> changeToDays({int? day}) async {
    int dayNumber = day ?? DateTime.now().weekday;

    if (dayNumber == 7) {
      dayNumber = 0;
    }

    final DayWidget dayWidget = _initial
        .firstWhere((DayWidget element) => element.dayNumber == dayNumber);
    final int index = _initial.indexOf(dayWidget);

    _days.clear();
    _days.addAll(_initial);
    _days[index] = dayWidget.copyWith(isSelected: true);
    setState(() {});

    _animeMapper.clear();
    await _animeMapper.getDiary(dayNumber);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async => changeToDays());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  ..._days.map(
                    (DayWidget e) => GestureDetector(
                      child: e,
                      onTap: () async => changeToDays(day: e.dayNumber),
                    ),
                  ),
                ],
              ),
            ),
            InfiniteScroll<AnimeMapper>(
              mapper: _animeMapper,
              builder: () => _animeMapper.nothingToShow<AnimeWidget>()
                  ? const NoElement()
                  : AnimeList(children: <Widget>[..._animeMapper.list]),
            ),
          ],
        ),
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final String day;
  final int dayNumber;
  final bool isSelected;

  const DayWidget({
    required this.day,
    this.dayNumber = 0,
    this.isSelected = false,
    super.key,
  });

  DayWidget copyWith({
    String? day,
    int? dayNumber,
    bool? isSelected,
  }) {
    return DayWidget(
      day: day ?? this.day,
      dayNumber: dayNumber ?? this.dayNumber,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextBorder(text: day, isSelected: isSelected);
  }
}
