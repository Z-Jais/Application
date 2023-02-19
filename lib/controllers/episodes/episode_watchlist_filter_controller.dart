import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeWatchlistFilterController extends EpisodeController {
  EpisodeWatchlistFilterController()
      : super(showActions: true, firstLoad: false);

  String toGzip() {
    final String base64 = base64Encode(
      gzip.encode(
        utf8.encode(
          jsonEncode(
            {
              'animes': AppController.watchlist.data,
              'episodes': AppController.seen.data,
              'episodeTypes':
                  FilterController.instance.watchlistEpisodeTypeFilter.data,
              'langTypes':
                  FilterController.instance.watchlistLangTypeFilter.data,
            },
          ),
        ),
      ),
    );
    log(base64);
    return base64;
  }

  @override
  Future<List<EpisodeWidget>> widgets() async {
    return URLController()
        .post(
          'https://${Const.serverUrl}/episodes/watchlist_filter/page/$page/limit/$limit',
          toGzip(),
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }
}
