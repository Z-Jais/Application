import 'package:flutter/material.dart';
import 'package:jais/components/mangas/manga_widget.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/mappers/manga_mapper.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MangaScanView extends StatefulWidget {
  const MangaScanView({super.key});

  @override
  State<MangaScanView> createState() => _MangaSearchViewState();
}

class _MangaSearchViewState extends State<MangaScanView> {
  final MangaMapper _mangaMapper = MangaMapper();
  bool _isShowned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MobileScanner(
            allowDuplicates: false,
            onDetect: (Barcode barcode, _) async {
              if (barcode.rawValue == null || _isShowned) {
                return;
              }

              final String ean = barcode.rawValue!;
              _isShowned = true;
              final Manga? manga = await _mangaMapper.search(ean);

              if (manga == null) {
                _isShowned = false;
                return;
              }

              await showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: MangaWidget(manga: manga, redirect: false),
                  );
                },
              );
              _isShowned = false;
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
