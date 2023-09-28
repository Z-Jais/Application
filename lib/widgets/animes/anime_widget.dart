import 'package:flutter/material.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:provider/provider.dart';

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
            ChangeNotifierProvider.value(
              value: anime,
              child: Consumer<Anime>(
                builder: (context, anime, _) {
                  return anime.inWatchlist
                      ? Positioned(
                          top: 0,
                          right: 2.5,
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
                              'Watchlist',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
