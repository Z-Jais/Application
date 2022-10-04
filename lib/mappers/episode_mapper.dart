import 'package:jais/components/episodes/episode_loader_widget.dart';
import 'package:jais/components/episodes/episode_widget.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url_const.dart';

class EpisodeMapper extends IMapper<Episode> {
  EpisodeMapper()
      : super(
          limit: 12,
          loaderWidget: const EpisodeLoaderWidget(),
          fromJson: Episode.fromJson,
          toWidget: (Episode episode) => EpisodeWidget(episode: episode),
        ) {
    notifyListeners();
  }

  @override
  Future<bool> updateCurrentPage() async => loadPage(
        UrlConst.getEpisodesPage(page, limit),
      );
}
