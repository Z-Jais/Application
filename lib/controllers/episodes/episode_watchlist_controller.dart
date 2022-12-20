import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeWatchlistController extends EpisodeController {
  @override
  Future<List<EpisodeWidget>> widgets() async {
    return URLController()
        .post(
          'https://beta-api.ziedelth.fr/episodes/watchlist/page/$page/limit/$limit',
          body: DeviceMapper.instance.animeWatchlistData.toGzip(),
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
