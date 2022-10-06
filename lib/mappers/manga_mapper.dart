import 'package:jais/components/episodes/episode_loader_widget.dart';
import 'package:jais/components/episodes/episode_widget.dart';
import 'package:jais/components/mangas/manga_loader_widget.dart';
import 'package:jais/components/mangas/manga_widget.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/mappers/imapper.dart';
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
  Future<bool> updateCurrentPage() async => loadPage(
        UrlConst.getMangasPage(page, limit),
      );
}
