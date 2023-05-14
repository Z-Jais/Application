import 'package:jais/controllers/abstract_filter.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeWatchlistFilterController extends EpisodeController
    with AbstractFilter {
  EpisodeWatchlistFilterController()
      : super(
          showActions: true,
          notifyListenersCallback: () {},
        );

  @override
  Future<List<EpisodeWidget>> widgets() async {
    return URLController()
        .post(
          '${Const.instance.serverUrlWithHttpProtocol}/episodes/watchlist_filter/page/$page/limit/$limit',
          toGzip(),
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
