import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_image.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/components/episodes/episode_image.dart';
import 'package:jais/components/platforms/platform_widget.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/url/url.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/utils/dictionary.dart';
import 'package:jais/utils/utils.dart';

class EpisodeWidget extends StatelessWidget {
  final Episode episode;

  const EpisodeWidget({required this.episode, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        URL.goOnUrl(episode.url);
      },
      child: BorderElement(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          PlatformWidget(platform: episode.platform),
                          const SizedBox(width: 7.5),
                          Expanded(
                            child: Text(
                              episode.platform.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        episode.anime.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        episode.title
                            .ifEmptyOrNull('＞﹏＜')
                            .replaceAll('\n', ' '),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Dictionary.getEpisodeDetails(episode),
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
                const SizedBox(width: 10),
                AnimeImage(anime: episode.anime),
              ],
            ),
            const SizedBox(height: 10),
            if (DeviceMapper.isOnMobile(context))
              EpisodeImage(episode: episode, height: Const.episodeImageHeight)
            else
              Expanded(child: EpisodeImage(episode: episode)),
            const SizedBox(height: 10),
            Text(
              'Il y a ${Utils.printTimeSince(DateTime.parse(episode.releaseDate))}',
            ),
          ],
        ),
      ),
    );
  }
}
