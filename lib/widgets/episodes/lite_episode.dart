import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/episode_more_options.dart';
import 'package:jais/widgets/episodes/lite_episode_image.dart';

class LiteEpisode extends StatelessWidget {
  final Episode episode;

  const LiteEpisode({required this.episode, super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: Utils.instance.buildBoxDecoration(context),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _onTap,
                child: LiteEpisodeImage(
                  episode: episode,
                  height: Const.episodeImageHeight / 2,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.title.ifEmptyOrNull('＞﹏＜').replaceAll('\n', ' '),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context)!.season(episode.season),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    AppLocalizations.of(context)!.minEpisodeDetails(
                      episode.number,
                      episode.episodeType.toStringTranslated(context),
                      episode.langType.toStringTranslated(context),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      EpisodeMoreOptions(
                        episode: episode,
                        onRedirectTap: _onTap,
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

  Future<void> _onTap() async {
    URLController().goOnUrl(episode.url);
  }
}
