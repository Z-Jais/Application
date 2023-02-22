import 'package:flutter/material.dart';
import 'package:jais/controllers/episodes/episode_watchlist_filter_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/widgets/episodes/episode_list.dart';
import 'package:jais/widgets/filter_watchlist.dart';

class EpisodeWatchlistTab extends StatefulWidget {
  const EpisodeWatchlistTab({super.key});

  @override
  State<StatefulWidget> createState() => _EpisodeWatchlistTabState();
}

class _EpisodeWatchlistTabState extends State<EpisodeWatchlistTab> {
  final _controller = EpisodeWatchlistFilterController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    info('EpisodeWatchlistTab', 'build()');
    return Column(
      children: [
        FilterWatchlist(
          onFilterChanged: () async {
            _controller.reset();
            await _controller.load();
          },
        ),
        Expanded(child: EpisodeList(controller: _controller)),
      ],
    );
  }
}
