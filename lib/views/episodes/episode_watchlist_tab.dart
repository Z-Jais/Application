import 'package:flutter/material.dart';
import 'package:jais/controllers/episodes/episode_watchlist_filter_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/widgets/episodes/episode_list.dart';

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
    return RefreshIndicator(
      child: EpisodeList(controller: _controller),
      onRefresh: () async {
        _controller.reset();
        await _controller.load();
      },
    );
  }
}
