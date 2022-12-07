import 'package:flutter/material.dart';
import 'package:jais/components/mangas/lite_manga_widget.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/mangas/manga_mapper.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MangaScanView extends StatefulWidget {
  const MangaScanView({super.key});

  @override
  State<MangaScanView> createState() => _MangaSearchViewState();
}

class _MangaSearchViewState extends State<MangaScanView> {
  final MangaMapper _mangaMapper = MangaMapper();
  final List<Manga> _mangas = <Manga>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MobileScanner(
            onDetect: (Barcode barcode, _) async {
              if (barcode.rawValue == null) {
                return;
              }

              final Manga? manga = await _mangaMapper.search(barcode.rawValue!);

              if (manga == null ||
                  _mangas.where((Manga m) => m.uuid == manga.uuid).isNotEmpty) {
                return;
              }

              _mangas.add(manga);
              setState(() {});
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Scanner le code barre',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_mangas.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Mangas scannés',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () async {
                            await DeviceMapper.instance.mangaWatchlistData
                                .addAll(
                              _mangas.map((Manga manga) => manga.uuid),
                            );

                            _mangas.clear();
                            setState(() {});
                          },
                          child: Row(
                            children: const <Widget>[
                              Text('Ajouter'),
                              SizedBox(width: 5),
                              Icon(Icons.add),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          ..._mangas.map(
                            (Manga manga) => LiteMangaWidget(manga: manga),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
