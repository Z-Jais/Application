import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/const.dart';

class AnimeImage extends StatelessWidget {
  final Anime anime;

  const AnimeImage({required this.anime, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${UrlConst.animeAttachment}${anime.uuid}',
      imageBuilder: (_, ImageProvider<Object> imageProvider) {
        return RoundBorderWidget(
          widget: Image(image: imageProvider, fit: BoxFit.cover),
        );
      },
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
    );
  }
}