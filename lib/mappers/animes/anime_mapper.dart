import 'package:jais/components/animes/anime_loader_widget.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url_const.dart';

class AnimeMapper extends IMapper<Anime> {
  Simulcast? simulcast;

  AnimeMapper({bool listener = true, bool clickable = true})
      : super(
          limit: 24,
          loaderWidget: const AnimeLoaderWidget(),
          fromJson: Anime.fromJson,
          toWidget: (Anime anime) => AnimeWidget(
            anime: anime,
            clickable: clickable,
          ),
          listener: listener,
        );

  @override
  Future<bool> updateCurrentPage() async {
    if (simulcast == null) {
      return false;
    }

    return loadPageWithUrl(UrlConst.getAnimesPage(simulcast!, page, limit));
  }

  Future<bool> search(String query) async {
    clear();
    return loadPageWithUrl(UrlConst.getAnimesSearch(query));
  }

  Future<bool> getDiary(int day) async {
    return loadPageWithUrl(UrlConst.getAnimesDiary(day));
  }
}
