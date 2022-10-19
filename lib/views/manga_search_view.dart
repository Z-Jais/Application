import 'package:flutter/material.dart';
import 'package:jais/components/mangas/manga_widget.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/mappers/manga_mapper.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MangaSearchView extends StatefulWidget {
  const MangaSearchView({super.key});

  @override
  State<MangaSearchView> createState() => _MangaSearchViewState();
}

class _MangaSearchViewState extends State<MangaSearchView> {
  final MangaMapper _mangaMapper = MangaMapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (Barcode barcode, _) async {
          if (barcode.rawValue == null) {
            return;
          }

          final String ean = barcode.rawValue!;
          final Manga? manga = await _mangaMapper.search(ean);

          if (manga == null) {
            return;
          }

          showBottomSheet(
            context: context,
            builder: (_) {
              return MangaWidget(manga: manga);
            },
          );
        },
      ),
    );
  }
}
