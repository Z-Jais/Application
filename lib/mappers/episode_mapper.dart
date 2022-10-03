import 'package:jais/components/episodes/episode_loader_widget.dart';
import 'package:jais/components/episodes/episode_widget.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/imapper.dart';

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
  Future<void> updateCurrentPage() async => loadPage(
        'https://beta-api.ziedelth.fr/episodes/country/fr/page/$page/limit/$limit',
      );
}
