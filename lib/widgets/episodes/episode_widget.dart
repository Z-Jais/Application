import 'package:flutter/material.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:jais/widgets/custom_badge.dart';
import 'package:jais/widgets/episodes/episode_image.dart';
import 'package:jais/widgets/episodes/episode_more_options.dart';
import 'package:jais/widgets/platforms/platform_widget.dart';

class EpisodeWidget extends StatelessWidget {
  final Episode episode;
  final void Function(Episode, bool)? onSeenTap;

  const EpisodeWidget({required this.episode, this.onSeenTap, super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
          Container(
            decoration: Utils.instance.buildBoxDecoration(context),
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
                GestureDetector(
                  onTap: _onTap,
                  child: EpisodeImage(episode: episode),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Il y a ${Utils.instance.printTimeSince(DateTime.parse(episode.releaseDate))}',
                    ),
                    const Spacer(),
                    EpisodeMoreOptions(
                      episode: episode,
                      onSeenTap: onSeenTap,
                      onRedirectTap: _onTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (episode.isNew)
            const Positioned(
              top: 0,
              right: 2.5,
              child: CustomBadge(text: 'New'),
            ),
        ],
      ),
    );
  }

  Future<void> _onTap() async {
    URLController().goOnUrl(episode.url);
  }
}
