import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/models/simulcast.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_loader_widget.dart';
import 'package:jais/widgets/animes/anime_widget.dart';

class AnimeController
    extends DataController<Anime, AnimeLoaderWidget, AnimeWidget> {
  Simulcast? simulcast;

  AnimeController({
    super.listener = true,
    super.addDefaultLoader = true,
    required super.notifyListenersCallback,
  }) : super(
          limit: 24,
          loadingWidget: const AnimeLoaderWidget(),
          fromJson: (json) => Anime.fromJson(json),
          toWidget: (anime) => AnimeWidget(anime: anime),
        );

  @override
  Future<List<AnimeWidget>> widgets() async {
    return URLController()
        .get(
          '${Const.instance.serverUrlWithHttpProtocol}/animes/country/${Const.selectedCountry}/simulcast/${simulcast?.uuid}/page/$page/limit/$limit',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
