import 'package:jais/components/episodes/lite_episode_loader_widget.dart';
import 'package:jais/components/episodes/lite_episode_widget.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url_const.dart';

class AnimeEpisodeMapper extends IMapper<Episode> {
  String? uuid;

  AnimeEpisodeMapper()
      : super(
          limit: 24,
          loaderWidget: const LiteEpisodeLoaderWidget(),
          fromJson: Episode.fromJson,
          toWidget: (Episode episode) => LiteEpisodeWidget(episode: episode),
        );

  @override
  Future<bool> updateCurrentPage() async {
    if (uuid == null) {
      return false;
    }

    return loadPageWithUrl(
      UrlConst.instance.getEpisodesAnimePage(uuid!, page, limit),
    );
  }
}
