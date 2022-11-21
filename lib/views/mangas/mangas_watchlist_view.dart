import 'package:flutter/material.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/mangas/manga_list.dart';
import 'package:jais/components/mangas/manga_widget.dart';
import 'package:jais/components/no_element.dart';
import 'package:jais/mappers/mangas/manga_watchlist_mapper.dart';

class MangasWatchlistView extends StatefulWidget {
  const MangasWatchlistView({super.key});

  @override
  State<MangasWatchlistView> createState() => _MangasWatchlistViewState();
}

class _MangasWatchlistViewState extends State<MangasWatchlistView> {
  final MangaWatchlistMapper _mangaWatchlistMapper = MangaWatchlistMapper();

  @override
  void initState() {
    super.initState();
    _mangaWatchlistMapper.clear();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => _mangaWatchlistMapper.updateCurrentPage(),
    );
  }

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
