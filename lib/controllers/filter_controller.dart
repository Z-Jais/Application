import 'package:jais/controllers/datas/collection_data_controller.dart';
import 'package:jais/controllers/datas/int_data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episodetype.dart';
import 'package:jais/models/langtype.dart';
import 'package:jais/utils.dart';

class FilterController {
  static final FilterController instance = FilterController();

  final CollectionDataController watchlistEpisodeTypeFilter =
      CollectionDataController('watchlistEpisodeTypeFilter');
  final CollectionDataController watchlistLangTypeFilter =
      CollectionDataController('watchlistLangTypeFilter');
  final IntDataController episodeWatchedFilter =
      IntDataController('episodeWatchedFilter');

  final List<EpisodeType> episodeTypes = [];
  final List<LangType> langTypes = [];

  Future<void> init() async {
    await Future.wait([
      URLController()
          .get('${Const.instance.serverUrlWithHttpProtocol}/episodetypes')
          .ifOk(
            (p0) => {
              episodeTypes.clear(),
              episodeTypes.addAll(
                p0.toJsonMapList.map((p0) => EpisodeType.fromJson(p0)),
              ),
            },
          ),
      watchlistEpisodeTypeFilter.init(),
      URLController()
          .get('${Const.instance.serverUrlWithHttpProtocol}/langtypes')
          .ifOk(
            (p0) => {
              langTypes.clear(),
              langTypes
                  .addAll(p0.toJsonMapList.map((p0) => LangType.fromJson(p0))),
            },
          ),
      watchlistLangTypeFilter.init(),
      episodeWatchedFilter.init(),
    ]);

    if (watchlistEpisodeTypeFilter.firstInit) {
      await watchlistEpisodeTypeFilter.addAll(
        episodeTypes.map((p0) => p0.uuid),
      );
    }

    if (watchlistLangTypeFilter.firstInit) {
      await watchlistLangTypeFilter.addAll(
        langTypes.map((p0) => p0.uuid),
      );
    }

    if (episodeWatchedFilter.firstInit) {
      episodeWatchedFilter.data = 0;
      await episodeWatchedFilter.save();
    }
  }
}
