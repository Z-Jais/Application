import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/simulcast_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';

class AnimeTabController with ChangeNotifier {
  late SimulcastController simulcastController;
  late AnimeController animeController;

  void setup() {
    simulcastController = SimulcastController(notifyListenersCallback: notify);
    animeController = AnimeController(notifyListenersCallback: notify);
  }

  Future<void> init() async {
    simulcastController.reset();
    await simulcastController.load();

    if (simulcastController.lastPageError) {
      return;
    }

    simulcastController.scrollController.scrollToEnd();
    animeController.simulcast =
        (simulcastController.list.last as SimulcastWidget).simulcast;
    animeController.reset();
    await animeController.load();

    notify();
  }

  void notify() {
    notifyListeners();
  }

  List<Widget> get simulcastWidgets {
    return simulcastController
        .setCurrent(animeController.simulcast)
        .map(
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
              notify();
            },
          ),
        )
        .toList();
  }
}
