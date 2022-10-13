import 'package:flutter/material.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/components/image_network.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/utils/utils.dart';

class MangaWidget extends StatelessWidget {
  final Manga manga;

  const MangaWidget({required this.manga, super.key});

  @override
  Widget build(BuildContext context) {
    return BorderElement(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: <Widget>[
            ImageNetwork(
              url: '${UrlConst.mangasAttachment}${manga.uuid}',
              width: Const.mangaImageWith,
              height: Const.mangaImageHeight,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    manga.anime.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    manga.ref.ifEmptyOrNull('Aucune référence pour le moment'),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    manga.editor,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Utils.printTimeSinceDays(
                      DateTime.parse(manga.releaseDate),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
