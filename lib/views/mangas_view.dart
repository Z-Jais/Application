import 'package:flutter/material.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/mangas/manga_list.dart';
import 'package:jais/mappers/manga_mapper.dart';

class MangasView extends StatefulWidget {
  const MangasView({super.key});

  @override
  State<MangasView> createState() => _MangasViewState();
}

class _MangasViewState extends State<MangasView> {
  final MangaMapper _mangaMapper = MangaMapper();

  @override
  void initState() {
    super.initState();
    _mangaMapper.clear();

    WidgetsBinding.instance
        .addPostFrameCallback((_) async => _mangaMapper.updateCurrentPage());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _mangaMapper.clear();
        _mangaMapper.updateCurrentPage();
      },
      child: InfiniteScroll<MangaMapper>(
        mapper: _mangaMapper,
        child: MangaList(
          scrollController: _mangaMapper.scrollController,
          children: _mangaMapper.list,
        ),
      ),
    );
  }
}
