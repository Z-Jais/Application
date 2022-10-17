import 'package:flutter/material.dart';
import 'package:jais/components/mangas/manga_loader_widget.dart';
import 'package:jais/components/mangas/manga_widget.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/mappers/manga_mapper.dart';

class MangaSearchView extends StatefulWidget {
  final String ean;

  const MangaSearchView({required this.ean, super.key});

  @override
  State<MangaSearchView> createState() => _MangaSearchViewState();
}

class _MangaSearchViewState extends State<MangaSearchView> {
  final MangaMapper _mangaMapper = MangaMapper();
  bool _isLoading = true;
  Manga? _manga;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final Manga? manga = await _mangaMapper.search(widget.ean);
      _isLoading = false;
      _manga = manga;

      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) {
      if (_manga == null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text('No manga found'),
          ],
        );
      }

      return MangaWidget(manga: _manga!);
    }

    return const MangaLoaderWidget();
  }
}
