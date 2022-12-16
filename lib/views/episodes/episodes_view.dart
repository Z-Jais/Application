import 'package:flutter/material.dart';
import 'package:jais/components/episodes/episode_list.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/mappers/episodes/episode_mapper.dart';

class EpisodesView extends StatelessWidget {
  final EpisodeMapper _episodeMapper = EpisodeMapper();

  EpisodesView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _episodeMapper.reset(),
      child: InfiniteScroll<EpisodeMapper>(
        mapper: _episodeMapper,
        builder: () => EpisodeList(
          scrollController: _episodeMapper.scrollController,
          children: <Widget>[..._episodeMapper.list],
        ),
      ),
    );
  }
}
