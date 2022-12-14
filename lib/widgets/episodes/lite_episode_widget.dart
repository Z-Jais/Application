import 'package:flutter/material.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/decoration/border_decoration.dart';
import 'package:jais/widgets/episodes/episode_see_widget.dart';
import 'package:jais/widgets/episodes/lite_episode_image.dart';
import 'package:jais/widgets/platforms/platform_widget.dart';

class LiteEpisodeWidget extends StatelessWidget {
  final Episode episode;
  final bool showActions;

  const LiteEpisodeWidget({
    required this.episode,
    this.showActions = false,
    super.key,
  });

  String getEpisodeType() {
    if (episode.episodeType.name == 'EPISODE') {
      return 'Épisode';
    }

    if (episode.episodeType.name == 'SPECIAL') {
      return 'Spécial';
    }

    if (episode.episodeType.name == 'FILM') {
      return 'Film';
    }

    return '??';
  }

  String getLangType() {
    if (episode.langType.name == 'SUBTITLES') {
      return 'VOSTFR';
    }

    if (episode.langType.name == 'VOICE') {
      return 'VF';
    }

    return '??';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        URLController().goOnUrl(episode.url);
      },
      child: BorderDecoration(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  LiteEpisodeImage(
                    episode: episode,
                    height: Const.episodeImageHeight / 2,
                  ),
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
                    'Saison ${episode.season}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${getEpisodeType()} ${episode.number} ${getLangType()}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.movie),
                      const SizedBox(width: 5),
                      Text(
                        Utils.instance.printDuration(
                          Duration(seconds: episode.duration),
                        ),
                      ),
                    ],
                  ),
                  if (showActions)
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        EpisodeSeeWidget(episode: episode),
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
