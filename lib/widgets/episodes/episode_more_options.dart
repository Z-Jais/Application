import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:provider/provider.dart';

class EpisodeMoreOptions extends StatelessWidget {
  final Episode episode;
  final void Function() onRedirectTap;

  const EpisodeMoreOptions({
    required this.episode,
    required this.onRedirectTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () async {
                await ProfileController.instance
                    .toggleEpisodeInWatchlist(episode);
              },
              child: ChangeNotifierProvider.value(
                value: episode,
                child: Consumer<Episode>(
                  builder: (context, value, child) {
                    final bool inWatchlist =
                        ProfileController.instance.isEpisodeInWatchlist(value);

                    return Row(
                      children: [
                        Icon(
                          inWatchlist ? Icons.visibility_off : Icons.visibility,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          inWatchlist
                              ? AppLocalizations.of(context)!.episodeNotWatched
                              : AppLocalizations.of(context)!.episodeWatched,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            PopupMenuItem(
              onTap: onRedirectTap,
              child: Row(
                children: [
                  const Icon(Icons.queue_play_next_rounded),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.goToEpisode),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}
