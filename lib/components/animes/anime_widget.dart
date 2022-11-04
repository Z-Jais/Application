import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_image.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/utils/utils.dart';

class AnimeWidget extends StatelessWidget {
  final Anime anime;

  const AnimeWidget({required this.anime, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamed('/anime/detail', arguments: anime);
      },
      child: BorderElement(
        child: Row(
          children: <Widget>[
            AnimeImage(anime: anime),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    anime.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    anime.description
                        .ifEmptyOrNull('Aucune description pour le moment'),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
