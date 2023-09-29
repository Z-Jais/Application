import 'package:flutter/material.dart';
import 'package:jais/models/missing_anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:jais/widgets/custom_badge.dart';

class MissingAnimeWidget extends StatelessWidget {
  final MissingAnime missingAnime;

  const MissingAnimeWidget({required this.missingAnime, super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () async {
          Navigator.of(context)
              .pushNamed('/anime/detail', arguments: missingAnime.anime);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  AnimeImage(
                    anime: missingAnime.anime,
                    width: Const.missingAnimeImageWith,
                    height: Const.missingAnimeImageHeight,
                    radius: 360,
                  ),
                  Positioned(
                    right: 0,
                    child: CustomBadge(
                      text: missingAnime.episodeCount >= 10
                          ? '9+'
                          : missingAnime.episodeCount.toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7.5),
              SizedBox(
                width: Const.missingAnimeImageWith + 30,
                child: Text(
                  missingAnime.anime.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
