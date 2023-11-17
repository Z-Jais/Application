import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  final bool showInWatchlist;

  const EpisodeWidget({
    required this.episode,
    this.showInWatchlist = true,
    super.key,
  });

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
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
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
                          GestureDetector(
                            onTap: () => _onAnimeTap(context),
                            child: Text(
                              episode.anime.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                          Text(
                            episode.title
                                .ifEmptyOrNull('＞﹏＜')
                                .replaceAll('\n', ' '),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.episodeDetails(
                              episode.number,
                              episode.episodeType.toStringTranslated(context),
                              episode.langType.toStringTranslated(context),
                              episode.season,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _onAnimeTap(context),
                      child: AnimeImage(anime: episode.anime),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _onTap,
                  child: EpisodeImage(
                    episode: episode,
                    showInWatchlist: showInWatchlist,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.timeSince(Utils.instance
                          .printTimeSince(context, episode.releaseDate)),
                    ),
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
          if (episode.isNew)
            Positioned(
              top: 0,
              right: 5,
              child: CustomBadge(text: AppLocalizations.of(context)!.newS),
            ),
        ],
      ),
    );
  }

  void _onTap() {
    URLController.instance.goOnUrl(episode.url);
  }

  void _onAnimeTap(BuildContext context) {
    Navigator.of(context).pushNamed('/anime/detail', arguments: episode.anime);
  }
}
