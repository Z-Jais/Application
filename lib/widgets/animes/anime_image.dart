import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/decoration/round_border_decoration.dart';
import 'package:jais/widgets/skeleton.dart';

class AnimeImage extends StatelessWidget {
  final Anime anime;
  final double width;
  final double height;
  final double radius;

  const AnimeImage({
    required this.anime,
    this.width = Const.animeImageWith,
    this.height = Const.animeImageHeight,
    this.radius = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          '${Const.instance.serverUrlWithHttpProtocol}/animes/attachment/${anime.uuid}',
      imageBuilder: (_, ImageProvider<Object> imageProvider) {
        return RoundBorderDecoration(
          widget: Image(image: imageProvider, fit: BoxFit.cover),
          radius: radius,
        );
      },
      placeholder: (_, __) => Skeleton(
        width: width,
        height: height,
        radius: radius,
      ),
      errorWidget: (_, __, ___) => Skeleton(
        width: width,
        height: height,
        radius: radius,
      ),
      width: width,
      height: height,
    );
  }
}
