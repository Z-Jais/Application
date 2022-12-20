import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/widgets/episodes/episode_loader_widget.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeController
    extends DataController<Episode, EpisodeLoaderWidget, EpisodeWidget> {
  EpisodeController()
      : super(
          limit: 12,
          loadingWidget: const EpisodeLoaderWidget(),
          fromJson: (json) => Episode.fromJson(json),
          toWidget: (episode) => EpisodeWidget(episode: episode),
        );

  @override
  Future<List<EpisodeWidget>> widgets() async {
    return URLController()
        .get(
          'https://beta-api.ziedelth.fr/episodes/country/fr/page/$page/limit/$limit',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
