import 'package:flutter/material.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/components/episodes/lite_episode_image.dart';
import 'package:jais/components/platforms/platform_widget.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/url/url.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/utils/dictionary.dart';
import 'package:jais/utils/utils.dart';

class LiteEpisodeWidget extends StatelessWidget {
  final Episode episode;

  const LiteEpisodeWidget({required this.episode, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        URL.goOnUrl(episode.url);
      },
      child: BorderElement(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  LiteEpisodeImage(
                      episode: episode, height: Const.episodeImageHeight / 2),
                  Positioned(
                    top: 2,
                    right: 3,
                    child: PlatformWidget(platform: episode.platform),
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    episode.title.ifEmptyOrNull('＞﹏＜').replaceAll('\n', ' '),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${Dictionary.getSeason()} ${episode.season}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${Dictionary.getEpisodeType(episode.episodeType)} ${episode.number} ${Dictionary.getLangType(episode.langType)}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.movie),
                      const SizedBox(width: 5),
                      Text(
                        Utils.printDuration(
                          Duration(seconds: episode.duration),
                        ),
                      ),
                    ],
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
