import 'package:flutter/material.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';

class ProfileAnime extends StatelessWidget {
  final Anime anime;

  const ProfileAnime({required this.anime, super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () => _onAnimeTap(context),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 2.5),
          child: Column(
            children: [
              AnimeImage(
                anime: anime,
                width: Const.profileAnimeImageWidth,
                height: Const.profileAnimeImageHeight,
              ),
              const SizedBox(height: 7.5),
              SizedBox(
                width: Const.profileAnimeImageWidth,
                height: 20,
                child: Text(
                  anime.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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

  void _onAnimeTap(BuildContext context) {
    Navigator.of(context).pushNamed('/anime/detail', arguments: anime);
  }
}
