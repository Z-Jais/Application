import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/models/episode.dart';

class EpisodeSeeWidget extends StatefulWidget {
  final Episode episode;
  final void Function(Episode, bool)? onTap;

  const EpisodeSeeWidget({
    required this.episode,
    this.onTap,
    super.key,
  });

  @override
  State<EpisodeSeeWidget> createState() => _EpisodeSeeWidgetState();
}

class _EpisodeSeeWidgetState extends State<EpisodeSeeWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isWatched = AppController.seen.hasIn(widget.episode.uuid);

    return GestureDetector(
      onTap: () async {
        if (isWatched) {
          await AppController.seen.remove(widget.episode.uuid);
        } else {
          await AppController.seen.add(widget.episode.uuid);
        }

        widget.onTap?.call(widget.episode, !isWatched);

        setState(() {});
      },
      child: Icon(
        isWatched ? Icons.visibility : Icons.visibility_off,
        color: isWatched ? Colors.green : Colors.grey,
      ),
    );
  }
}
