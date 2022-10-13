import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/components/image_network.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/utils/utils.dart';

class AnimeWidget extends StatelessWidget {
  final Anime anime;

  const AnimeWidget({required this.anime, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/anime/${anime.uuid}'),
      child: BorderElement(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            children: <Widget>[
              ImageNetwork(
                url: '${UrlConst.animeAttachment}${anime.uuid}',
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
        ),
      ),
    );
  }
}
