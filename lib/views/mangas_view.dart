import 'package:flutter/material.dart';
import 'package:jais/components/mangas/manga_list.dart';
import 'package:jais/mappers/manga_mapper.dart';
import 'package:provider/provider.dart';

class MangasView extends StatefulWidget {
  const MangasView({super.key});

  @override
  State<MangasView> createState() => _MangasViewState();
}

class _MangasViewState extends State<MangasView> {
  final MangaMapper _mangaMapper = MangaMapper();
  UniqueKey _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _mangaMapper.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _mangaMapper.updateCurrentPage();

      if (!mounted) {
        return;
      }

      setState(() => _key = UniqueKey());
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _mangaMapper.clear();
        _mangaMapper.updateCurrentPage();
      },
      child: ChangeNotifierProvider<MangaMapper>.value(
        value: _mangaMapper,
        child: Consumer<MangaMapper>(
          builder: (_, MangaMapper mangaMapper, __) {
            return MangaList(
              key: _key,
              scrollController: _mangaMapper.scrollController,
              children: mangaMapper.list,
            );
          },
        ),
      ),
    );
  }
}
