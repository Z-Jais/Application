import 'package:flutter/material.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/episode_see_widget.dart';
import 'package:jais/widgets/episodes/lite_episode_image.dart';

class LiteEpisodeWidget extends StatelessWidget {
  final Episode episode;
  final bool showActions;

  const LiteEpisodeWidget({
    required this.episode,
    this.showActions = false,
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
          child: Row(
            children: <Widget>[
              Expanded(
                child: LiteEpisodeImage(
                  episode: episode,
                  height: Const.episodeImageHeight / 2,
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
                      '${episode.episodeType} ${episode.number} ${episode.langType}',
                      overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
