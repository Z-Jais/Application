import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_widget.dart';

class AnimeSearchController extends AnimeController {
  String? query;

  AnimeSearchController()
      : super(
          listener: false,
          addDefaultLoader: false,
          notifyListenersCallback: () {},
        );

  @override
  Future<List<AnimeWidget>> widgets() async {
    return URLController()
        .get(
          '${Const.instance.serverUrlWithHttpProtocol}/animes/country/${Const.selectedCountry}/search/name/$query',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
