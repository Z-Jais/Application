import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/widgets/episodes/profile_episode.dart';
import 'package:jais/widgets/episodes/profile_episode_loader.dart';

class ProfileEpisodeController
    extends DataController<Episode, ProfileEpisodeLoader, ProfileEpisode> {
  ProfileEpisodeController()
      : super(
          limit: 12,
          loadingWidget: const ProfileEpisodeLoader(),
          fromJson: (json) => Episode.fromJson(json),
          toWidget: (episode) => ProfileEpisode(episode: episode),
          notifyListenersCallback: () {},
        );

  @override
  Future<List<ProfileEpisode>> widgets() async {
    return ProfileController.instance
        .getEpisodes(page, limit)
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
