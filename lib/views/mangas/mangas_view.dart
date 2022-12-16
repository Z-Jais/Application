import 'package:flutter/material.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/mangas/manga_list.dart';
import 'package:jais/mappers/mangas/manga_mapper.dart';

class MangasView extends StatelessWidget {
  final MangaMapper _mangaMapper = MangaMapper();

  MangasView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _mangaMapper.reset(),
      child: InfiniteScroll<MangaMapper>(
        mapper: _mangaMapper,
        builder: () => MangaList(
          scrollController: _mangaMapper.scrollController,
          children: <Widget>[..._mangaMapper.list],
        ),
      ),
    );
  }
}
