import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/missing_anime_controller.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';

class EpisodeTabController with ChangeNotifier {
  late MissingAnimeController missingAnimeController;
  late EpisodeController episodeController;

  void setup() {
    missingAnimeController =
        MissingAnimeController(notifyListenersCallback: notify);
    episodeController = EpisodeController(notifyListenersCallback: notify);
  }

  Future<void> init() async {
    missingAnimeController.reset();
    episodeController.reset();
    notify();

    missingAnimeController.load().whenComplete(() => notify());
    episodeController.load().whenComplete(() => notify());
  }

  void notify() {
    notifyListeners();
  }
}
