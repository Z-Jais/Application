import 'package:jais/controllers/abstract_filter.dart';
import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/missing_anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/missing_anime_loader_widget.dart';
import 'package:jais/widgets/animes/missing_anime_widget.dart';

class MissingAnimeController extends DataController<MissingAnime,
    MissingAnimeLoaderWidget, MissingAnimeWidget> with AbstractFilter {
  MissingAnimeController({required super.notifyListenersCallback})
      : super(
          limit: 12,
          loadingWidget: const MissingAnimeLoaderWidget(),
          fromJson: (json) => MissingAnime.fromJson(json),
          toWidget: (anime) => MissingAnimeWidget(missingAnime: anime),
        );

  @override
  Future<List<MissingAnimeWidget>> widgets() async {
    return URLController()
        .post(
          '${Const.instance.serverUrlWithHttpProtocol}/animes/missing/page/$page/limit/$limit',
          toGzip(sendSeen: true),
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
