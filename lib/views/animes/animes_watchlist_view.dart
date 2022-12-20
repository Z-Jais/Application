import 'package:flutter/material.dart';
import 'package:jais/mappers/animes/anime_watchlist_mapper.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/animes/anime_widget.dart';
import 'package:jais/widgets/infinite_scroll.dart';
import 'package:jais/widgets/no_element.dart';

class AnimesWatchlistView extends StatelessWidget {
  final AnimeWatchlistMapper _animeWatchlistMapper = AnimeWatchlistMapper();

  AnimesWatchlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _animeWatchlistMapper.reset(),
      child: SingleChildScrollView(
        controller: _animeWatchlistMapper.scrollController,
        child: InfiniteScroll<AnimeWatchlistMapper>(
          controller: _animeWatchlistMapper,
          builder: () => _animeWatchlistMapper.nothingToShow<AnimeWidget>()
              ? const NoElement()
              : AnimeList(children: <Widget>[..._animeWatchlistMapper.list]),
        ),
      ),
    );
  }
}
