import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/episode_image.dart';

class ProfileEpisode extends StatelessWidget {
  final Episode episode;

  const ProfileEpisode({required this.episode, super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () => _onAnimeTap(context),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 2.5),
          child: Column(
            children: [
              EpisodeImage(
                episode: episode,
                showInWatchlist: false,
                width: Const.profileEpisodeImageWidth,
                height: Const.profileEpisodeImageHeight,
              ),
              const SizedBox(height: 7.5),
              SizedBox(
                width: Const.profileEpisodeImageWidth,
                height: 40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.anime.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      ),
    );
  }

  void _onAnimeTap(BuildContext context) {
    Navigator.of(context).pushNamed('/anime/detail', arguments: episode.anime);
  }
}
