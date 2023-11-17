import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/widgets/animes/anime_loader_widget.dart';
import 'package:jais/widgets/animes/anime_widget.dart';

class AnimeWatchlistController
    extends DataController<Anime, AnimeLoaderWidget, AnimeWidget> {
  AnimeWatchlistController()
      : super(
          limit: 24,
          loadingWidget: const AnimeLoaderWidget(),
          fromJson: (json) => Anime.fromJson(json),
          toWidget: (anime) => AnimeWidget(
            anime: anime,
            showInWatchlist: false,
          ),
          notifyListenersCallback: () {},
        );

  @override
  Future<List<AnimeWidget>> widgets() async {
    return ProfileController.instance
        .getAnimes(page, limit)
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
