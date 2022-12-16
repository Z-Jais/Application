import 'package:flutter/material.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/mangas/manga_list.dart';
import 'package:jais/components/mangas/manga_widget.dart';
import 'package:jais/components/no_element.dart';
import 'package:jais/mappers/mangas/manga_watchlist_mapper.dart';

class MangasWatchlistView extends StatelessWidget {
  final MangaWatchlistMapper _mangaWatchlistMapper = MangaWatchlistMapper();

  MangasWatchlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _mangaWatchlistMapper.reset(),
      child: InfiniteScroll<MangaWatchlistMapper>(
        mapper: _mangaWatchlistMapper,
        builder: () => _mangaWatchlistMapper.nothingToShow<MangaWidget>()
            ? const NoElement()
            : MangaList(
          scrollController: _mangaWatchlistMapper.scrollController,
          children: <Widget>[..._mangaWatchlistMapper.list],
        ),
      ),
    );
  }
}
