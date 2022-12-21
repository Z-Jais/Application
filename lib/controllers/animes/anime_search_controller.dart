import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/widgets/animes/anime_widget.dart';

class AnimeSearchController extends AnimeController {
  String? query;

  AnimeSearchController()
      : super(
          firstLoad: false,
          listener: false,
        );

  @override
  Future<List<AnimeWidget>> widgets() async {
    return URLController()
        .get(
          'https://beta-api.ziedelth.fr/animes/country/fr/search/name/$query',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
