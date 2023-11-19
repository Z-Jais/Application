import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/episode_loader.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeController
    extends DataController<Episode, EpisodeLoader, EpisodeWidget> {
  EpisodeController({required super.notifyListenersCallback})
      : super(
          limit: 12,
          loadingWidget: const EpisodeLoader(),
          fromJson: (json) => Episode.fromJson(json),
          toWidget: (episode) => EpisodeWidget(episode: episode),
        );

  @override
  Future<List<EpisodeWidget>> widgets() async {
    return URLController.instance
        .get(
          '${Const.instance.serverUrlWithHttpProtocol}/episodes/country/${Const.selectedCountry}/page/$page/limit/$limit',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
