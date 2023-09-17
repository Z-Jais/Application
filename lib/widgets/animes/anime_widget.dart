import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';

class AnimeWidget extends StatelessWidget {
  final Anime anime;

  const AnimeWidget({required this.anime, super.key});

  Widget borderDecoration(BuildContext context) {
    return Container(
      decoration: Utils.instance.buildBoxDecoration(context),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
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
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () async {
          Navigator.of(context).pushNamed('/anime/detail', arguments: anime);
        },
        child: Stack(
          children: [
            borderDecoration(context),
            if (AppController.watchlist.hasIn(anime.uuid))
              Badge(
                smallSize: 16,
                backgroundColor: Theme.of(context).primaryColor,
                child: borderDecoration(context),
              ),
          ],
        ),
      ),
    );
  }
}
