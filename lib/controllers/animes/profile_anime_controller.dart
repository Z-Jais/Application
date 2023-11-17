import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/widgets/animes/profile_anime.dart';
import 'package:jais/widgets/animes/profile_anime_loader.dart';

class ProfileAnimeController
    extends DataController<Anime, ProfileAnimeLoader, ProfileAnime> {
  ProfileAnimeController()
      : super(
          limit: 24,
          loadingWidget: const ProfileAnimeLoader(),
          fromJson: (json) => Anime.fromJson(json),
          toWidget: (anime) => ProfileAnime(anime: anime),
          notifyListenersCallback: () {},
        );

  @override
  Future<List<ProfileAnime>> widgets() async {
    return ProfileController.instance
        .getAnimes(page, limit)
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
