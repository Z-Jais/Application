import 'dart:convert';

import 'package:http/http.dart';
import 'package:jais/components/mangas/manga_loader_widget.dart';
import 'package:jais/components/mangas/manga_widget.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';

class MangaMapper extends IMapper<Manga> {
  MangaMapper()
      : super(
          limit: 24,
    loaderWidget: const MangaLoaderWidget(),
    fromJson: Manga.fromJson,
    toWidget: (Manga manga) => MangaWidget(manga: manga),
        ) {
    notifyListeners();
  }

  @override
  Future<bool> updateCurrentPage() async {
    return loadPage(
      UrlConst.getMangasPage(page, limit),
    );
  }

  Future<Manga?> search(String ean) async {
    final Response? response = await URL().get(UrlConst.getMangaSearch(ean));

    if (!response.isOk) {
      return null;
    }

    return fromJson(
        jsonDecode(utf8.decode(response!.bodyBytes)) as Map<String, dynamic>);
  }
}
