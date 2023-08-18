import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:jais/controllers/animes/missing_anime_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:jais/widgets/animes/missing_anime_widget.dart';

class HomeWidgetController {
  late MissingAnimeController missingAnimeController;
  static const int limit = 4;

  void init() {
    missingAnimeController =
        MissingAnimeController(limit: 4, notifyListenersCallback: () {});
  }

  Future<void> notify() async {
    missingAnimeController.reset();
    await missingAnimeController.load();

    try {
      final List<AnimeImage> animeImages = [];

      for (int i = 0; i < limit; i++) {
        final MissingAnimeWidget? missingAnimeWidget =
            missingAnimeController.list.elementAtOrNull(i)
                as MissingAnimeWidget?;

        if (missingAnimeWidget == null) {
          break;
        }

        final Anime anime = missingAnimeWidget.missingAnime.anime;

        animeImages.add(
          AnimeImage(
            anime: anime,
            width: Const.missingAnimeImageWith * 10,
            height: Const.missingAnimeImageHeight * 10,
            radius: 360,
          ),
        );
      }

      info(
        'EpisodeTabController',
        'updateHomeWidget() - ${animeImages.length} images',
      );

      if (animeImages.isNotEmpty) {
        await Future.wait([
          for (final AnimeImage image in animeImages)
            HomeWidget.renderFlutterWidget(
              image,
              logicalSize: const Size(
                Const.missingAnimeImageWith * 10,
                Const.missingAnimeImageHeight * 10,
              ),
              key: 'image${animeImages.indexOf(image)}',
            ),
        ]);
      } else {
        await Future.wait([
          for (int i = 0; i < limit; i++)
            HomeWidget.saveWidgetData('image$i', null),
        ]);
      }

      await HomeWidget.updateWidget(name: 'HomeWidgetProvider');
    } catch (exception, stackTrace) {
      error('EpisodeTabController', '$exception', exception, stackTrace);
    }
  }
}
