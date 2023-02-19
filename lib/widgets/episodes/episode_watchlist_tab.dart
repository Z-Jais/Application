import 'package:flutter/material.dart';
import 'package:jais/controllers/episodes/episode_watchlist_filter_controller.dart';
import 'package:jais/widgets/episodes/episode_list.dart';
import 'package:jais/widgets/filter_watchlist.dart';

class EpisodeWatchlistTab extends StatelessWidget {
  final EpisodeWatchlistFilterController controller;

  const EpisodeWatchlistTab({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.load(),
      builder: (context, snapshot) {
        return Column(
          children: [
            FilterWatchlist(
              onFilterChanged: () async {
                controller.reset();
                await controller.load();
              },
            ),
            Expanded(child: EpisodeList(controller: controller)),
          ],
        );
      },
    );
  }
}
