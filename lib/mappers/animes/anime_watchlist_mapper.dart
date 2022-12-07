import 'package:jais/components/animes/anime_loader_widget.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';

class AnimeWatchlistMapper extends IMapper<Anime> {
  AnimeWatchlistMapper()
      : super(
          limit: 24,
          loaderWidget: const AnimeLoaderWidget(),
          fromJson: Anime.fromJson,
          toWidget: (Anime anime) => AnimeWidget(anime: anime),
        );

  @override
  Future<bool> updateCurrentPage() async {
    return loadPageWithFunction(
      () async => URL().post(
        UrlConst.instance.getAnimesWatchlistPage(page, limit),
        body: DeviceMapper.instance.animeWatchlistData.toGzip(),
      ),
    );
  }
}
