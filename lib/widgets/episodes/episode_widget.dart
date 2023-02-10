import 'package:flutter/material.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:jais/widgets/decoration/border_decoration.dart';
import 'package:jais/widgets/episodes/episode_image.dart';
import 'package:jais/widgets/episodes/episode_see_widget.dart';
import 'package:jais/widgets/platforms/platform_widget.dart';

class EpisodeWidget extends StatelessWidget {
  final Episode episode;
  final bool showActions;

  const EpisodeWidget({
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
      child: RepaintBoundary(
        child: BorderDecoration(
          hoverListener: true,
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
                          'Saison ${episode.season} • ${getEpisodeType()} ${episode.number} ${getLangType()}',
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
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  AnimeImage(anime: episode.anime),
                ],
              ),
              const SizedBox(height: 10),
              if (context.isOnMobile)
                EpisodeImage(episode: episode, height: Const.episodeImageHeight)
              else
                Expanded(child: EpisodeImage(episode: episode)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Il y a ${Utils.instance.printTimeSince(DateTime.parse(episode.releaseDate))}',
                  ),
                  const Spacer(),
                  if (showActions) EpisodeSeeWidget(episode: episode),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
