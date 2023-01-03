import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/widgets/episodes/lite_episode_loader_widget.dart';
import 'package:jais/widgets/episodes/lite_episode_widget.dart';

class AnimeDetailController extends DataController<Episode,
    LiteEpisodeLoaderWidget, LiteEpisodeWidget> {
  Anime? _anime;

  AnimeDetailController()
      : super(
          limit: 12,
          loadingWidget: const LiteEpisodeLoaderWidget(),
          fromJson: (json) => Episode.fromJson(json),
          toWidget: (episode) => LiteEpisodeWidget(
            episode: episode,
            showActions: true,
          ),
          firstLoad: false,
        );

  Anime? get anime => _anime;

  set anime(Anime? anime) {
    if (_anime != null) {
      return;
    }

    _anime = anime;
    reset();
    load();
  }

  @override
  Future<List<LiteEpisodeWidget>> widgets() async {
    return URLController()
        .get(
          'https://beta-api.ziedelth.fr/episodes/anime/${_anime?.uuid}/page/$page/limit/$limit',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
