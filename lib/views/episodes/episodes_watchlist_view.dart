import 'package:flutter/material.dart';
import 'package:jais/mappers/episodes/episode_watchlist_mapper.dart';
import 'package:jais/widgets/episodes/episode_list.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';
import 'package:jais/widgets/infinite_scroll.dart';
import 'package:jais/widgets/no_element.dart';

class EpisodesWatchlistView extends StatelessWidget {
  final EpisodeWatchlistMapper _episodeWatchlistMapper =
      EpisodeWatchlistMapper();

  EpisodesWatchlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _episodeWatchlistMapper.reset(),
      child: InfiniteScroll<EpisodeWatchlistMapper>(
        controller: _episodeWatchlistMapper,
        builder: () => _episodeWatchlistMapper.nothingToShow<EpisodeWidget>()
            ? const NoElement()
            : EpisodeList(
                scrollController: _episodeWatchlistMapper.scrollController,
                children: <Widget>[..._episodeWatchlistMapper.list],
              ),
      ),
    );
  }
}
