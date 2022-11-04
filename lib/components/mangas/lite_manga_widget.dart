import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/const.dart';

class LiteMangaWidget extends StatelessWidget {
  final Manga manga;

  const LiteMangaWidget({required this.manga, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${UrlConst.mangasAttachment}${manga.uuid}',
      imageBuilder: (_, ImageProvider<Object> imageProvider) {
        return RoundBorderWidget(
          widget: Image(image: imageProvider, fit: BoxFit.cover),
        );
      },
      placeholder: (_, __) => const Skeleton(
        width: Const.mangaImageWith,
        height: Const.mangaImageHeight,
      ),
      errorWidget: (_, __, ___) => const Skeleton(
        width: Const.mangaImageWith,
        height: Const.mangaImageHeight,
      ),
      width: Const.mangaImageWith,
      height: Const.mangaImageHeight,
    );
  }
}
