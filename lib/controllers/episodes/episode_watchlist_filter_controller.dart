import 'package:jais/controllers/abstract_filter.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeWatchlistFilterController extends EpisodeController
    with AbstractFilter {
  final List<String> _seen = [];

  EpisodeWatchlistFilterController({
    required void Function(Episode, bool) onTap,
  }) : super(
          showActions: true,
          onTap: onTap,
          notifyListenersCallback: () {},
        );

  List<String> get seen => _seen;

  @override
  Future<List<EpisodeWidget>> widgets() async {
    return URLController()
        .post(
          '${Const.instance.serverUrlWithHttpProtocol}/episodes/watchlist_filter/page/$page/limit/$limit',
          toGzip(remove: _seen),
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
