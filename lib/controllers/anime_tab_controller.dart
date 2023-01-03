import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/simulcast_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';

class AnimeTabController with ChangeNotifier {
  final SimulcastController simulcastController = SimulcastController();
  final AnimeController animeController = AnimeController(firstLoad: false);

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

    notifyListeners();
  }
}
