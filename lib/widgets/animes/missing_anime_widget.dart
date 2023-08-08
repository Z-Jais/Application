import 'package:flutter/material.dart';
import 'package:jais/models/missing_anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';

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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: AnimeImage(
                      anime: missingAnime.anime,
                      width: Const.missingAnimeImageWith,
                      height: Const.missingAnimeImageHeight,
                      radius: 360,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Text(
                        missingAnime.episodeCount >= 10
                            ? '9+'
                            : missingAnime.episodeCount.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
