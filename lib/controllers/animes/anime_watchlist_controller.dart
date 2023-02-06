import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_widget.dart';

class AnimeWatchlistController extends AnimeController {
  @override
  Future<List<AnimeWidget>> widgets() async {
    return URLController()
        .post(
          'https://${Const.serverUrl}/animes/watchlist/page/$page/limit/$limit',
          AppController.watchlist.toGzip(),
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
