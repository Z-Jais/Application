import 'package:jais/components/mangas/manga_loader_widget.dart';
import 'package:jais/components/mangas/manga_widget.dart';
import 'package:jais/entities/manga.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';

class MangaWatchlistMapper extends IMapper<Manga> {
  MangaWatchlistMapper()
      : super(
          limit: 24,
          loaderWidget: const MangaLoaderWidget(),
          fromJson: Manga.fromJson,
          toWidget: (Manga manga) => MangaWidget(manga: manga),
        );

  @override
  Future<bool> updateCurrentPage() async {
    return loadPageWithFunction(
      () async => URL().post(
        UrlConst.getMangasWatchlistPage(page, limit),
        body: await DeviceMapper.mangaWatchlistData.toGzip(),
      ),
    );
  }
}
