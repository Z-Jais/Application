import 'package:flutter/material.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:jais/widgets/decoration/border_decoration.dart';

class AnimeWidget extends StatelessWidget {
  final Anime anime;
  final bool clickable;

  const AnimeWidget({required this.anime, this.clickable = true, super.key});

  Widget _widget(BuildContext context) {
    return BorderDecoration(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!clickable) {
      return _widget(context);
    }

    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamed('/anime/detail', arguments: anime);
      },
      child: _widget(context),
    );
  }
}
