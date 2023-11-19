import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/missing_anime.dart';
import 'package:jais/widgets/animes/missing_anime_loader_widget.dart';
import 'package:jais/widgets/animes/missing_anime_widget.dart';

class MissingAnimeController extends DataController<MissingAnime,
    MissingAnimeLoader, MissingAnimeWidget> {
  MissingAnimeController({required super.notifyListenersCallback})
      : super(
          limit: 12,
          loadingWidget: const MissingAnimeLoader(),
          fromJson: (json) => MissingAnime.fromJson(json),
          toWidget: (anime) => MissingAnimeWidget(missingAnime: anime),
        );

  @override
  Future<List<MissingAnimeWidget>> widgets() async {
    return ProfileController.instance
        .getMissingAnimes(page, limit)
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
