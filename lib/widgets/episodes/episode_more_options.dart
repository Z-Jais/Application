import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:provider/provider.dart';

class EpisodeMoreOptions extends StatelessWidget {
  final Episode episode;
  final void Function() onRedirectTap;
  final void Function(Episode, bool)? onSeenTap;

  const EpisodeMoreOptions({
    required this.episode,
    required this.onRedirectTap,
    this.onSeenTap,
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
              onTap: _onTap,
              child: ChangeNotifierProvider.value(
                value: episode,
                child: Consumer<Episode>(
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        Icon(value.isSeen
                            ? Icons.visibility_off
                            : Icons.visibility),
                        const SizedBox(width: 8),
                        Text(
                          value.isSeen
                              ? "Je n'ai pas vu cet épisode"
                              : "J'ai vu cet épisode",
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            PopupMenuItem(
              onTap: onRedirectTap,
              child: const Row(
                children: [
                  Icon(Icons.queue_play_next_rounded),
                  SizedBox(width: 8),
                  Text("Aller sur l'épisode"),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }

  Future<void> _onTap() async {
    final isSeen = episode.isSeen;

    if (isSeen) {
      await AppController.seen.remove(episode.uuid);
    } else {
      await AppController.seen.add(episode.uuid);
    }

    onSeenTap?.call(episode, !isSeen);
    episode.notify();
  }
}
