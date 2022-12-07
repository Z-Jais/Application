import 'package:jais/components/animes/anime_loader_widget.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url_const.dart';

class AnimeMapper extends IMapper<Anime> {
  Simulcast? simulcast;

  AnimeMapper({super.listener, bool clickable = true})
      : super(
          limit: 24,
          loaderWidget: const AnimeLoaderWidget(),
          fromJson: Anime.fromJson,
          toWidget: (Anime anime) => AnimeWidget(
            anime: anime,
            clickable: clickable,
          ),
        );

  @override
  Future<bool> updateCurrentPage() async {
    if (simulcast == null) {
      return false;
    }

    return loadPageWithUrl(
      UrlConst.instance.getAnimesPage(simulcast!, page, limit),
    );
  }

  Future<bool> search(String query) async {
    clear();
    return loadPageWithUrl(UrlConst.instance.getAnimesSearch(query));
  }

  Future<bool> getDiary(int day) async {
    return loadPageWithUrl(UrlConst.instance.getAnimesDiary(day));
  }
}
