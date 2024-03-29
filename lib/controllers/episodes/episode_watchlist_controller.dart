import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/widgets/episodes/episode_loader.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeWatchlistController
    extends DataController<Episode, EpisodeLoader, EpisodeWidget> {
  EpisodeWatchlistController()
      : super(
          limit: 12,
          loadingWidget: const EpisodeLoader(),
          fromJson: (json) => Episode.fromJson(json),
          toWidget: (episode) => EpisodeWidget(
            episode: episode,
            showInWatchlist: false,
          ),
          notifyListenersCallback: () {},
        );

  @override
  Future<List<EpisodeWidget>> widgets() async {
    return ProfileController.instance
        .getEpisodes(page, limit)
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
