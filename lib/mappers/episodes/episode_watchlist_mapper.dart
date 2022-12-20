import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/widgets/episodes/episode_loader_widget.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeWatchlistMapper extends IMapper<Episode> {
  EpisodeWatchlistMapper()
      : super(
          limit: 12,
          loaderWidget: const EpisodeLoaderWidget(),
          fromJson: Episode.fromJson,
          toWidget: (Episode episode) => EpisodeWidget(episode: episode),
        ) {
    updateCurrentPage();
  }

  @override
  Future<bool> updateCurrentPage() async {
    return loadPageWithFunction(
      () async => URL().post(
        UrlConst.instance.getEpisodesWatchlistPage(page, limit),
        body: DeviceMapper.instance.animeWatchlistData.toGzip(),
      ),
    );
  }
}
