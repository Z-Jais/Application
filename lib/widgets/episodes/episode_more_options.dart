import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/models/episode.dart';

class EpisodeMoreOptions extends StatefulWidget {
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
  State<EpisodeMoreOptions> createState() => _EpisodeMoreOptionsState();
}

class _EpisodeMoreOptionsState extends State<EpisodeMoreOptions> {
  late bool _hasSee;

  @override
  void initState() {
    _hasSee = AppController.seen.hasIn(widget.episode.uuid);
    super.initState();
  }

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
              child: Row(
                children: [
                  Icon(_hasSee ? Icons.visibility_off : Icons.visibility),
                  const SizedBox(width: 8),
                  Text(
                    _hasSee
                        ? "Je n'ai pas vu cet épisode"
                        : "J'ai vu cet épisode",
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: widget.onRedirectTap,
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
    if (_hasSee) {
      await AppController.seen.remove(widget.episode.uuid);
    } else {
      await AppController.seen.add(widget.episode.uuid);
    }

    widget.onSeenTap?.call(widget.episode, !_hasSee);

    setState(() {
      _hasSee = !_hasSee;
    });
  }
}
