import 'package:flutter/material.dart';
import 'package:jais/components/episodes/episode_list.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/no_element.dart';
import 'package:jais/mappers/episodes/episode_watchlist_mapper.dart';

class EpisodesWatchlistView extends StatefulWidget {
  const EpisodesWatchlistView({super.key});

  @override
  State<EpisodesWatchlistView> createState() => _EpisodesWatchlistViewState();
}

class _EpisodesWatchlistViewState extends State<EpisodesWatchlistView> {
  final EpisodeWatchlistMapper _episodeWatchlistMapper =
      EpisodeWatchlistMapper();

  @override
  void initState() {
    super.initState();
    _episodeWatchlistMapper.clear();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => _episodeWatchlistMapper.updateCurrentPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _episodeWatchlistMapper.clear();
        _episodeWatchlistMapper.updateCurrentPage();
      },
      child: InfiniteScroll<EpisodeWatchlistMapper>(
        mapper: _episodeWatchlistMapper,
        builder: () =>
            _episodeWatchlistMapper.nothingToShow<EpisodeWatchlistMapper>()
                ? const NoElement()
                : EpisodeList(
                    scrollController: _episodeWatchlistMapper.scrollController,
                    children: _episodeWatchlistMapper.list,
                  ),
      ),
    );
  }
}
