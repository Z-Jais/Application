import 'package:flutter/material.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:jais/widgets/episodes/episode_image.dart';
import 'package:jais/widgets/episodes/episode_see_widget.dart';
import 'package:jais/widgets/platforms/platform_widget.dart';

class EpisodeWidget extends StatelessWidget {
  final Episode episode;
  final bool showActions;
  final void Function(Episode, bool)? onTap;

  const EpisodeWidget({
    required this.episode,
    this.showActions = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () async {
          URLController().goOnUrl(episode.url);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                  fontSize: 13,
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
                            fontSize: 15,
                          ),
                        ),
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
                          'Saison ${episode.season} • ${episode.episodeType} ${episode.number} ${episode.langType}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  AnimeImage(anime: episode.anime),
                ],
              ),
              const SizedBox(height: 10),
              EpisodeImage(episode: episode),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Il y a ${Utils.instance.printTimeSince(DateTime.parse(episode.releaseDate))}',
                  ),
                  const Spacer(),
                  if (showActions)
                    EpisodeSeeWidget(
                      episode: episode,
                      onTap: onTap,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
