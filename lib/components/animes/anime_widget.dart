import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/utils/utils.dart';

class AnimeWidget extends StatelessWidget {
  final Anime anime;

  const AnimeWidget({required this.anime, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: '${UrlConst.animeAttachment}${anime.uuid}',
            imageBuilder: (_, ImageProvider<Object> imageProvider) =>
                RoundBorderWidget(
              widget: Image(image: imageProvider, fit: BoxFit.cover),
            ),
            placeholder: (_, __) => const Skeleton(
              width: Const.animeImageWith,
              height: Const.animeImageHeight,
            ),
            errorWidget: (_, __, ___) => const Skeleton(
              width: Const.animeImageWith,
              height: Const.animeImageHeight,
            ),
            width: Const.animeImageWith,
            height: Const.animeImageHeight,
          ),
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
}
