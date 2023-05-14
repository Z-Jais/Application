import 'dart:convert';
import 'dart:io';

import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/filter_controller.dart';

mixin class AbstractFilter {
  List<String> _episodes(bool sendSeen) {
    if (sendSeen) {
      return AppController.seen.data;
    }

    return FilterController.instance.episodeWatchedFilter.data == 0
        ? AppController.seen.data
        : [];
  }

  String toGzip({bool sendSeen = false}) {
    return base64Encode(
      gzip.encode(
        utf8.encode(
          jsonEncode(
            {
              'animes': AppController.watchlist.data,
              'episodes': _episodes(sendSeen),
              'episodeTypes':
                  FilterController.instance.watchlistEpisodeTypeFilter.data,
              'langTypes':
                  FilterController.instance.watchlistLangTypeFilter.data,
            },
          ),
        ),
      ),
    );
  }
}
