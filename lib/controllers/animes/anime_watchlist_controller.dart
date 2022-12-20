import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/widgets/animes/anime_widget.dart';

class AnimeWatchlistController extends AnimeController {
  @override
  Future<List<AnimeWidget>> widgets() async {
    return URLController()
        .post(
          'https://beta-api.ziedelth.fr/animes/watchlist/page/$page/limit/$limit',
          body: DeviceMapper.instance.animeWatchlistData.toGzip(),
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
