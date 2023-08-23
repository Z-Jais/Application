import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/episode_loader_widget.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeController
    extends DataController<Episode, EpisodeLoaderWidget, EpisodeWidget> {
  EpisodeController({
    bool showActions = false,
    void Function(Episode, bool)? onTap,
    required super.notifyListenersCallback,
  }) : super(
          limit: 12,
          loadingWidget: const EpisodeLoaderWidget(),
          fromJson: (json) => Episode.fromJson(json),
          toWidget: (episode) => EpisodeWidget(
            episode: episode,
            showActions: showActions,
            onTap: onTap,
          ),
        );

  @override
  Future<List<EpisodeWidget>> widgets() async {
    return URLController()
        .get(
          '${Const.instance.serverUrlWithHttpProtocol}/episodes/country/fr/page/$page/limit/$limit',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
