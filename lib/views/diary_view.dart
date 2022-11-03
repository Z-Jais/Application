import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_list.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/no_element.dart';
import 'package:jais/mappers/animes/anime_mapper.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
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
      dayNumber: 0,
    ),
  ];
  final List<DayWidget> _days = <DayWidget>[];

  Future<void> changeToDays({int? day}) async {
    day ??= DateTime.now().weekday;

    if (day == 7) {
      day = 0;
    }

    final DayWidget dayWidget =
        _initial.firstWhere((DayWidget element) => element.dayNumber == day);
    final int index = _initial.indexOf(dayWidget);

    _days.clear();
    _days.addAll(_initial);
    _days[index] = dayWidget.copyWith(isSelected: true);
    setState(() {});

    _animeMapper.clear();
    await _animeMapper.getDiary(day);
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
            const SizedBox(height: 10),
            InfiniteScroll<AnimeMapper>(
              mapper: _animeMapper,
              builder: () => _animeMapper.nothingToShow<AnimeWidget>()
                  ? const NoElement()
                  : AnimeList(children: _animeMapper.list),
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
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      ),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
    );
  }
}
