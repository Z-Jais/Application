import 'package:flutter/material.dart';
import 'package:jais/components/episodes/episode_list.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/mappers/episodes/episode_mapper.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<EpisodesView> {
  final EpisodeMapper _episodeMapper = EpisodeMapper();

  @override
  void initState() {
    super.initState();
    _episodeMapper.clear();

    WidgetsBinding.instance
        .addPostFrameCallback((_) async => _episodeMapper.updateCurrentPage());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _episodeMapper.reset(),
      child: InfiniteScroll<EpisodeMapper>(
        mapper: _episodeMapper,
        builder: () => EpisodeList(
          scrollController: _episodeMapper.scrollController,
          children: _episodeMapper.list,
        ),
      ),
    );
  }
}
