import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/models/simulcast.dart';
import 'package:jais/widgets/animes/anime_loader_widget.dart';
import 'package:jais/widgets/animes/anime_widget.dart';

class AnimeController
    extends DataController<Anime, AnimeLoaderWidget, AnimeWidget> {
  Simulcast? simulcast;

  AnimeController()
      : super(
          limit: 24,
          loadingWidget: const AnimeLoaderWidget(),
          fromJson: (json) => Anime.fromJson(json),
          toWidget: (anime) => AnimeWidget(anime: anime),
        );

  @override
  Future<List<AnimeWidget>> widgets() async {
    return URLController()
        .get(
          'https://beta-api.ziedelth.fr/animes/country/fr/simulcast/${simulcast?.uuid}/page/$page/limit/$limit',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
