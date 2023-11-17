import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/lite_episode_loader.dart';
import 'package:jais/widgets/episodes/lite_episode.dart';

class AnimeDetailController
    extends DataController<Episode, LiteEpisodeLoader, LiteEpisode> {
  Anime? _anime;

  AnimeDetailController()
      : super(
          limit: 12,
          loadingWidget: const LiteEpisodeLoader(),
          fromJson: (json) => Episode.fromJson(json),
          toWidget: (episode) => LiteEpisode(episode: episode),
          notifyListenersCallback: () {},
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
  Future<List<LiteEpisode>> widgets() async {
    return URLController.instance
        .get(
          '${Const.instance.serverUrlWithHttpProtocol}/episodes/anime/${_anime?.uuid}/page/$page/limit/$limit',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
