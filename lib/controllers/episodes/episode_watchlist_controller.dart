import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeWatchlistController extends EpisodeController {
  EpisodeWatchlistController() : super(showActions: true);

  @override
  Future<List<EpisodeWidget>> widgets() async {
    return URLController()
        .post(
          'https://beta-api.ziedelth.fr/episodes/watchlist/page/$page/limit/$limit',
          body: AppController.watchlist.toGzip(),
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
