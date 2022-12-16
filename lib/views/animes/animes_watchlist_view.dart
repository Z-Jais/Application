import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_list.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/no_element.dart';
import 'package:jais/mappers/animes/anime_watchlist_mapper.dart';

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
          mapper: _animeWatchlistMapper,
          builder: () => _animeWatchlistMapper.nothingToShow<AnimeWidget>()
              ? const NoElement()
              : AnimeList(children: <Widget>[..._animeWatchlistMapper.list]),
        ),
      ),
    );
  }
}
