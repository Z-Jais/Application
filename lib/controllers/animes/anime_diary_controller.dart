import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/widgets/animes/anime_widget.dart';
import 'package:jais/widgets/day_widget.dart';

class AnimeDiaryController extends AnimeController {
  late int _day;
  final List<DayWidget> _initial = const [
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
  final List<DayWidget> days = [];

  AnimeDiaryController()
      : super(
          firstLoad: false,
          listener: false,
        ) {
    day = DateTime.now().weekday;
    load();
  }

  int get day => _day;

  set day(int day) {
    int dayNumber = day;

    if (dayNumber == 7) {
      dayNumber = 0;
    }

    _day = dayNumber;
    final DayWidget dayWidget = _initial
        .firstWhere((DayWidget element) => element.dayNumber == dayNumber);
    final int index = _initial.indexOf(dayWidget);

    days.clear();
    days.addAll(_initial);
    days[index] = dayWidget.copyWith(isSelected: true);

    reset();
    load();
  }

  @override
  Future<List<AnimeWidget>> widgets() async {
    return URLController()
        .get(
          'https://beta-api.ziedelth.fr/animes/diary/country/fr/day/$_day',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
